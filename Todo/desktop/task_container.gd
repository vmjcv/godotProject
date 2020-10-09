extends VBoxContainer

onready var task_panel = preload("res://desktop/LineEdit.tscn")

signal close
signal finish

func _ready():
	$"AddTaskPanel".connect("add_task",self,"add_task")


func add_task():
	var task = task_panel.instance()
	self.add_child(task)
	task.connect("top",self,"top_task",[task])
	task.connect("finish",self,"finish_task",[task])
	task.connect("close",self,"close_task",[task])
	move_child($"AddTaskPanel",self.get_child_count())
	
func top_task(node):
	move_child(node,0)
	pass
	
func close_task(node):
	emit_signal("close",node)
	delete_task(node)
	pass

func finish_task(node):
	emit_signal("finish",node)
	delete_task(node)
	pass
	
func delete_task(node):
	remove_child(node)
