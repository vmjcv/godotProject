extends Area2D
#signal _mouse_entered
#signal _mouse_exited

export var number = 0

func _ready():
	#connect("mouse_entered",self,"_mouse_entered")
	#connect("mouse_exited",self,"_mouse_exited")
	#connect("_mouse_entered",ItemManage,"mouse_entered")
	#connect("_mouse_exited",ItemManage,"mouse_exited")
	pass # Replace with function body.

func _mouse_entered():
	print("1111111111111")
	emit_signal("_mouse_entered",self)
	
func _mouse_exited():
	print("222222222")
	emit_signal("_mouse_exited",self)


func _on_Area2D_mouse_entered():
	print("111111111")
	pass # Replace with function body.
