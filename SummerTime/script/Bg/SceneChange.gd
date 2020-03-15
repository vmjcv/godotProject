extends Control
signal change_left_scene
signal change_right_scene
signal change_up_scene
signal change_down_scene
onready var left_node = get_node("Left")
onready var right_node = get_node("Right")
onready var up_node = get_node("Up")
onready var down_node = get_node("Down")

func _ready():
	_init_signal()

func _init_signal():
	SceneManage.connect("change_scene", self, "change_scene")
	connect("change_left_scene",SceneManage,"change_left_scene")
	connect("change_right_scene",SceneManage,"change_right_scene")
	connect("change_up_scene",SceneManage,"change_up_scene")
	connect("change_down_scene",SceneManage,"change_down_scene")
	pass # Replace with function body.

func _on_Left_button_up():
	emit_signal("change_left_scene")
	pass # Replace with function body.


func _on_Right_button_up():
	emit_signal("change_right_scene")
	
	pass # Replace with function body.


func _on_Up_button_up():
	emit_signal("change_up_scene")
	
	pass # Replace with function body.


func _on_Down_button_up():
	emit_signal("change_down_scene")
	pass # Replace with function body.
	
func change_scene(left,right,up,down):
	left_node.visible=left>=0
	right_node.visible=right>=0
	up_node.visible=up>=0
	down_node.visible=down>=0
	

