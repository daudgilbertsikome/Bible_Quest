extends KinematicBody2D

var gravitasi = 12
var speed = 30
var motion = Vector2.ZERO
export var arah = 1

var apakah_terluka = false

onready var pivot = $Pivot
onready var raycast = $Pivot/RayCast2D
onready var damage_sound = $damagesound

export var hp = 3

# ambil parent
onready var parent_node = get_parent().get_parent()

func _ready():
	pass

func _physics_process(_delta):
	motion.y += gravitasi
	
	if is_on_wall() or not raycast.is_colliding():
		arah = arah * -1
		pivot.scale.x = pivot.scale.x * -1
	
	# 	cek apakah player di lock dari controler?? 
	#   player di lock dikarenakan beberapa reason
	#   misal: player sedang membuka info atau sedang mengerjakan kuis
	#   karena player di lock, maka enemy pun di lock
	if(parent_node.playerMoveByController):
		motion.x = speed * arah
	else:
		motion.x = 0
		
	if not apakah_terluka:
		motion = move_and_slide(motion, Vector2.UP)
	
	if not apakah_terluka:
		_update_animasi()

func _update_animasi():
	if is_on_floor():
		$AnimatedSprite.play("lari")
	else:
		$AnimatedSprite.play("jatuh")
	$AnimatedSprite.flip_h = true
	if arah == -1:
		$AnimatedSprite.flip_h = false


func _on_DeteksiSamping_body_entered(body):
	if body.name == 'Hero':
		body.terluka()


func _on_DeteksiAtas_body_entered(body):
	if body.name == "Hero" and not apakah_terluka and hp > 0:
		body.motion.y = -200
		terluka()

func terluka():
	hp -= 1
	apakah_terluka = true
	$AnimatedSprite.play("terluka")
	damage_sound.play() # Mainkan suara damage
	yield(get_tree().create_timer(0.5), "timeout")
	print("HP: ", hp)
	if hp <= 0:
		mati()
	else:
		apakah_terluka = false

func mati():
	$AnimatedSprite.play("mati")
	set_collision_layer_bit(2, false)
	set_collision_mask_bit(0, false)
	$DeteksiSamping.set_collision_layer_bit(2, false)
	$DeteksiSamping.set_collision_mask_bit(0, false)
	$DeteksiAtas.set_collision_layer_bit(2, false)
	$DeteksiAtas.set_collision_mask_bit(0, false)
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("menghilang")
	
func hapus():
	print("HAPUS!")
	queue_free()
