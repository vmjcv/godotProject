extends Button

# 道具槽位类
const NORMAL = preload("res://images/styleboxflat/normal.tres")

func _init():
	pass

func _ready():
	update_styles()
	pass
	
func add_item(node):
	add_child(node)
	node.name="Icon"
	node.rect_position=Vector2(0,0)

func update_styles():
	var result_box = NORMAL
	add_stylebox_override("hover",result_box)
	add_stylebox_override("pressed",result_box)
	add_stylebox_override("focus",result_box)
	add_stylebox_override("disabled",result_box)
	add_stylebox_override("normal",result_box)
	


