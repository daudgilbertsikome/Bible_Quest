extends CanvasLayer

onready var tween = $Tween
signal info_setPlayerMoveByController(value)
# Referensi ke PauseMenu
var popup_pause = preload("res://PopupPause.tscn")
var sudah_muncul = false

	
func _ready():
	pass

func _process(_delta):
	pass
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_ButtonPause_pressed()
	
func _on_ButtonPause_pressed():
	if not sudah_muncul:
		sudah_muncul = true
		muncul()
		
	var instance_popup_pause = popup_pause.instance()
	add_child(instance_popup_pause)
	instance_popup_pause.show_popup()
	# Hubungkan sinyal dari instance popup pause
	instance_popup_pause.connect("info_setPlayerMoveByController", self, "_on_PopupPause_info_setPlayerMoveByController")
	emit_signal("info_setPlayerMoveByController", false) # hentikan waktu hero dan enemy
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -231, 55, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()


func _on_PopupPause_info_setPlayerMoveByController(value):
	# Terima signal dari PopupPause dan teruskan ke Node2D atau node lain yang mengelola kontrol
	emit_signal("info_setPlayerMoveByController", value)


func _on_PopupKalah_info_setPlayerMoveByController(value):
	# Terima signal dari PopupPause dan teruskan ke Node2D atau node lain yang mengelola kontrol
	emit_signal("info_setPlayerMoveByController", value)
