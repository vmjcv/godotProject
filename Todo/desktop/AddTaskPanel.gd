extends PanelContainer


signal add_task
func _ready():
	pass

func _on_addtask_pressed():
	emit_signal("add_task")


func _on_AddTask_mouse_entered():
	self.modulate.a=1


func _on_AddTask_mouse_exited():
	self.modulate.a=0
