extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var correct = get_node("GreenCheckmark")
onready var wrong = get_node("RedCross")

# Called when the node enters the scene tree for the first time.
func _ready():
	setCorrect(true)

func setCorrect(value):
	if value:
		correct.visible = true
		wrong.visible = false
	else:
		correct.visible = false
		wrong.visible = true
