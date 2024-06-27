extends Node2D

onready var health_progress = $CanvasLayer/HealthBar/TextureProgress
onready var jumlah_koin = $CanvasLayer/CoinBar/Label
onready var pause_popup = $CanvasLayer/PopupPause
# mode agar HP Player tidak berkurang
onready var debugMode = false
# mode agar Helper aktif (tidak masuk jurang dst)
onready var debugMode_helper = false
# OBJ lantai pembantu agar Player tidak masuk jurang
onready var helper_platform = $debugHelper01
# player can move by controller
onready var playerMoveByController = true
onready var enemyMoveByController = true
export var stageNow = -1

onready var hero = get_node("Hero")

		
func resetStage():
	if stageNow == 1:
		get_tree().change_scene("res://Level1.tscn")
	if stageNow == 2:
		get_tree().change_scene("res://Level2.tscn")
	if stageNow == 3:
		get_tree().change_scene("res://Level3.tscn")


func _on_Hero_hero_apdet_health(value):
	health_progress.value = value


func _on_Hero_hero_apdet_koin(value):
	jumlah_koin.text = String(value)

func _ready():
	# helper agar player, tidak jatuh ke jurang, default helper non aktif. jika ingin mengubah, ubah di variable baris 6 dan 8
	var collisionHelper_disabled = true
	# jika helper aktif maka
	if debugMode_helper:
		collisionHelper_disabled = false
	
	# implementasi debugMode_helper 
	for child in helper_platform.get_children():
		if child is CollisionShape2D:
		  child.set_disabled(collisionHelper_disabled)
	
	hero.resetTimePass() # reset cooldown player dapat hit checkpoint
	CheckpointGame.load_game_state(self) # load checkpoint
	

func _on_ButtonOk_pressed():
	pass # Replace with function body.


func _on_PopupInfo_info_setPlayerMoveByController(value):
	setPlayerMoveByController(value) # disable enable enemy dan hero

func CheckpointGame_state():
	CheckpointGame.save_game_state(self) # save checkpoint

func getStage():
	return stageNow # mereturn variable stageNow

func _on_PopupQuiz_info_setPlayerMoveByController(value):
	setPlayerMoveByController(value) # disable enable enemy dan hero

func _on_ButtonRetry_pressed():
	hero.resetTimePass()
	CheckpointGame.load_game_state(self)
	
func setPlayerMoveByController(value):
	# jika true, maka hero dan enemy bisa bergerak, 
	# jika false, maka hero dan enemy tidak bisa bergerak, 
	# biasanya digunakan agar ketika ada popup info atau quiz, player bisa membaca / menjawab tanpa takut ada intrupsi dari enemy atau player tidak sengaja bergerak
	playerMoveByController = value
	enemyMoveByController = value

func hapusCheckpoint():
	CheckpointGame.delete_checkpoint()


func _on_PopupPause_info_setPlayerMoveByController(value):
	setPlayerMoveByController(value) # disable enable enemy dan hero


func _on_CanvasLayer_info_setPlayerMoveByController(value):
	setPlayerMoveByController(value) # disable enable enemy dan hero


func _on_CanvasLayer2_info_setPlayerMoveByController(value):
	setPlayerMoveByController(value) # disable enable enemy dan hero


func _on_CanvasLayer3_info_setPlayerMoveByController(value):
	setPlayerMoveByController(value) # disable enable enemy dan hero
