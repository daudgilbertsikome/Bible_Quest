extends CenterContainer

onready var tween = $Tween

signal info_setPlayerMoveByController(value)

var sudah_muncul = false
var parent_node = null
# stageNow di ambil dari parent_node, di lakukan di _ready() 
var stageNow = 0

func _ready():
	parent_node = get_parent().get_parent() # get parent node, biasanya adalah Level1, Level2, Level3 dst
	stageNow = parent_node.getStage() # dari parent node kita bisa mengetahui saat ini stage berapa? apakah stageNow = 1. stageNow = 2. stageNow = 3 dst dst  

		

func show_popup():
	# Menampilkan pop-up
	visible = true
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -231, 55, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()

#func _on_TmblUlangi_pressed():
#	get_tree().change_scene("res://Level1.tscn")
#
#func _on_Hero_hero_mati():
##	if not sudah_muncul:
##		sudah_muncul = true
#		muncul()
	
func _on_ButtonMulaiLagi_pressed():
	parent_node.resetStage()
	parent_node.hapusCheckpoint()
	$SoundTombol.play()
	

func _on_ButtonKeluarPauseLevel1_pressed():
	if stageNow == 1:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
		$SoundTombol.play()
	if stageNow == 2:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
		$SoundTombol.play()
	if stageNow == 3:
		parent_node.hapusCheckpoint()
		get_tree().change_scene("res://Title.tscn")
		$SoundTombol.play()


func _on_ButtonLanjutkan_pressed():
	# Sembunyikan popup pause
	hide()
	emit_signal("info_setPlayerMoveByController", true) # hero dan enemy bisa bebas bergerak lagi
	self.visible = false # gui kita sembunyikan dari tampilan user
	$SoundTombol.play()
