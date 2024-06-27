extends Node2D



func _ready():
	$AnimationPlayer.play("fade in")
	yield(get_tree().create_timer(6), "timeout")
	$AnimationPlayer.play("fade out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Title.tscn")
