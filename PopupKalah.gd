extends CenterContainer

onready var tween = $Tween
onready var defeat_sound =  $suarakalah # Referensi ke node AudioStreamPlayer2D
signal info_setPlayerMoveByController(value)
var sudah_muncul = false
var parent_node = null
# stageNow di ambil dari parent_node, di lakukan di _ready() 
var stageNow = 0

func _ready():
	parent_node = get_parent().get_parent() # get parent node, biasanya adalah Level1, Level2, Level3 dst
	stageNow = parent_node.getStage() # dari parent node kita bisa mengetahui saat ini stage berapa? apakah stageNow = 1. stageNow = 2. stageNow = 3 dst dst  

		
func muncul():
	tween.interpolate_property(self, "rect_position:y", -233, 55, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	# Mainkan suara pop-up kalah
	defeat_sound.play()

#func _on_TmblUlangi_pressed():
#	get_tree().change_scene("res://Level1.tscn")
#
#func _on_Hero_hero_mati():
##	if not sudah_muncul:
##		sudah_muncul = true
#		muncul()

func _on_Hero_hero_mati():
	if not sudah_muncul:
		sudah_muncul = true
		emit_signal("info_setPlayerMoveByController", false) # hentikan waktu hero dan enemy
		muncul()

func _on_ButtonCobaLagi_pressed():
	parent_node.resetStage()
	


func _on_ButtonKeluarKalahLevel1_pressed():
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")


func _on_ButtonKeluarKalahLevel2_pressed():
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")


func _on_ButtonKeluarKalahLevel3_pressed():
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")


func _on_ZonaJatuh_body_entered(body):
	if body.name == 'Hero':
		# Ketika karakter terjatuh ke jurang, tampilkan pop-up kalah
		_on_Hero_hero_mati()


func _on_ButtonMulaiLagi_pressed():
	parent_node.resetStage()
	parent_node.hapusCheckpoint()
