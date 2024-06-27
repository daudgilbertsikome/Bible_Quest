extends KinematicBody2D

var dash_speed = 500
var normal_speed = 140
var speed = normal_speed
var motion = Vector2.ZERO
var laju_lompat = -225
var gravitasi = 12
var koin = 0
var sedang_terluka = false
var health_maks = 100
var health = 100
var double_jump = false
var menunduk = false

onready var sprite = $Sprite
onready var footstep_timer = $FootstepTimer

signal hero_mati
signal hero_menang
signal hero_apdet_health(value)
signal hero_apdet_koin(value)

# ambil parent
onready var parent_node = get_parent()
# waktu digunakan untuk disable "save" ketika player "load" ke checkpoint
# karena posisi "load" checkpoint sama dengan posisi "save" maka ini akan 
# menimbulkan trigger otomatis yang tidak kita inginkan
var timePass = 0.0
var timePassMax = 2.0
var canCheckPoint_dueToTime = false
 
func _ready():
	footstep_timer.connect("timeout", self, "_on_FootstepTimer_timeout")

func _physics_process(delta):
	motion.y = motion.y + gravitasi
	
	#	check apakah waktu sudah over?
	if timePass < timePassMax :
		timePass += delta
	#	jika sudah over maka, hero dapat checkpoint
	else:
		canCheckPoint_dueToTime = true
	
	# 	cek apakah player di lock dari controler?? 
	#   player di lock dikarenakan beberapa reason
	#   misal: player sedang membuka info atau sedang mengerjakan kuis
	if(parent_node.playerMoveByController):
		if(not sedang_terluka and Input.is_action_pressed("gerak_kanan")):
			motion.x = speed
			if footstep_timer.is_stopped():
				footstep_timer.start()
		if(not sedang_terluka and Input.is_action_pressed("gerak_kiri")):
			motion.x = -speed
			if footstep_timer.is_stopped():
				footstep_timer.start()
		if(not sedang_terluka and Input.is_action_just_pressed("lari_cepat")):
			lari_cepat()
			
		if(not sedang_terluka and Input.is_action_pressed("menunduk")):
			menunduk = true
			motion.x = 0
		
		if(not sedang_terluka and Input.is_action_pressed("lompat") and is_on_floor()):
			motion.y = laju_lompat
			double_jump = true
			$SoundJump.play()
		elif double_jump and Input.is_action_just_pressed("lompat"):
			motion.y = laju_lompat
			double_jump = false
			$SoundJump.play()
	
	motion.x = lerp(motion.x, 0, 0.2)
	motion = move_and_slide(motion, Vector2.UP)
	
	if not sedang_terluka:
		update_animasi()
	
	if motion.x == 0 or not is_on_floor():
		footstep_timer.stop()  # Stop footstep sounds if not moving or in the air

func update_animasi():
	if is_on_floor():
		if motion.x < (speed * 0.5) and motion.x > (-speed * 0.5):
			sprite.play("Diam")
		else:
			if speed == normal_speed:
				sprite.play("Lari")
			elif speed == dash_speed:
				sprite.play("LariCepat")
	else:
		if motion.y > 0:
			# jatuh
			sprite.play("Jatuh")
		elif double_jump:
			# lompat
			sprite.play("Lompat")
		else:
			#lompat
			sprite.play("DoubleJump")
	
	sprite.flip_h = false
	if motion.x < 0:
		sprite.flip_h = true

func lari_cepat():
	speed = dash_speed
	$Timer.start()

func _on_Timer_timeout():
	speed = normal_speed

func _on_FootstepTimer_timeout():
	if is_on_floor() and motion.x != 0:
		$SoundFootstep.play()
		
func ambil_koin():
	koin = koin + 1
#	print(" KOIN: ", koin)
	emit_signal("hero_apdet_koin", koin)
	$soundcoin.play()
	# Cek jumlah koin
	var grup_koin = get_tree().get_nodes_in_group("GrupKoin")
	var jumlah_koin = grup_koin.size()
	print(" GRUP KOIN: ", grup_koin)
	print(" JUMLAH: ", jumlah_koin)
	# Kalau habis, panggil signal hero_menang
	if jumlah_koin == 0:
		# kondisi menang by coin is disable
		# emit_signal("hero_menang")

		pass
		

func terluka():
	sedang_terluka = true
	if parent_node.debugMode:
		health -= 0
	else:
		health -= 15
	emit_signal("hero_apdet_health", (float(health)/float(health_maks)) * 100)
	
	if motion.x > 0:
		motion.x = -500
	else:
		motion.x = 500
	"res://sounds/Footstep_Left_Stone.ogg"
	sprite.play("Terluka")
	$Soundkenadamage.play()
	yield(get_tree().create_timer(0.2), "timeout")
	
	if health <= 0:
		mati()
	else:
		sedang_terluka = false

func mati():
	sprite.play("Mati")
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(2, false)
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("hero_mati")

func loadGuiHero():
	emit_signal("hero_apdet_koin", koin)
	emit_signal("hero_apdet_health", (float(health)/float(health_maks)) * 100)

func resetTimePass():
	canCheckPoint_dueToTime = false
	timePass = 0
	
func heroWin():
	emit_signal("hero_menang")
