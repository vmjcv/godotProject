tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var checkButton=get_child(0)
	var size = checkButton.rect_size
	var scale = checkButton.rect_scale
	rect_min_size=Vector2(size[0]*scale[0],size[1]*scale[1])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
