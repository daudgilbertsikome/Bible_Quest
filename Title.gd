extends Node2D

var popup_tentang = preload("res://Tentang.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_TombolMulai_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_TombolTentang_pressed():
	var instance_popup_tentang = popup_tentang.instance()
	add_child(instance_popup_tentang)
	instance_popup_tentang.show_popup()
