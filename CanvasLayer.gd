extends CanvasLayer

onready var tween = $Tween

var popup_tentang = preload("res://Tentang.tscn")
var cara_bermain = preload("res://CaraBermain.tscn")
var kredit = preload("res://Kredit.tscn")
var sudah_muncul = false

func _ready():
	pass

func _process(_delta):
	pass


func _on_TombolMulai_pressed():
	get_tree().change_scene("res://Level1.tscn")
	$SoundTombol.play()

func muncul():
	tween.interpolate_property(self, "rect_position:y", -260, 9, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
#func _on_TombolTentang_pressed():
#	if not sudah_muncul:
#		sudah_muncul = true
#		muncul()
		
#	var instance_popup_tentang = popup_tentang.instance()
#	add_child(instance_popup_tentang)
#	instance_popup_tentang.show_popup()
	

func _on_TombolTentang_pressed():
	if not sudah_muncul:
		sudah_muncul = true
		muncul()
	$SoundTombol.play()
		
	var instance_popup_tentang = popup_tentang.instance()
	add_child(instance_popup_tentang)
	instance_popup_tentang.show_popup()


func _on_TombolKeluar_pressed():
	get_tree().quit()
	$SoundTombol.play()

func _on_TombolCaraBermain_pressed():
	if not sudah_muncul:
		sudah_muncul = true
		muncul()
	$SoundTombol.play()
		
	var instance_cara_bermain = cara_bermain.instance()
	add_child(instance_cara_bermain)
	instance_cara_bermain.show_popup()


func _on_TombolKredit_pressed():
	if not sudah_muncul:
		sudah_muncul = true
		muncul()
	$SoundTombol.play()
		
	var instance_kredit = kredit.instance()
	add_child(instance_kredit)
	instance_kredit.show_popup()

