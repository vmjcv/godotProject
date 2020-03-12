extends Area2D
signal _area_entered
signal _area_exited

export var number = 0

func _ready():
	connect("area_entered",self,"_area_entered")
	connect("area_exited",self,"_area_exited")
	connect("_area_entered",ItemManage,"area_entered")
	connect("_area_exited",ItemManage,"area_exited")
	pass # Replace with function body.

func _area_entered(other_area):
	print("1111111111111")
	emit_signal("_area_entered",self)
	
func _area_exited(other_area):
	print("222222222")
	emit_signal("_area_exited",self)
