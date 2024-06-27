extends CenterContainer

onready var tween = $Tween

var sudah_muncul = false
# akan di link kan dengan node levelxx, di lakukan di _ready()
var parent_node = null
# stageNow di ambil dari parent_node, di lakukan di _ready() 
var stageNow = 0

func _ready():
	parent_node = get_parent().get_parent() # get parent node, biasanya adalah Level1, Level2, Level3 dst
	stageNow = parent_node.getStage() # dari parent node kita bisa mengetahui saat ini stage berapa? apakah stageNow = 1. stageNow = 2. stageNow = 3 dst dst  

	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -231, 55, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()

func _on_Hero_hero_menang():
	muncul()


func _on_ButtonSelanjutnya_pressed():
	# kita sudah win
	# check sekarang level apa, dan mau kemana
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Level2.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Level3.tscn")
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Level1.tscn")


func _on_ButtonKeluarMenang_pressed():
	# kita sudah win
	# check sekarang level apa, dan mau kemana
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")


func _on_ButtonKeluarMenangLevel1_pressed():
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")


func _on_ButtonKeluar2MenangLevel3_pressed():
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
