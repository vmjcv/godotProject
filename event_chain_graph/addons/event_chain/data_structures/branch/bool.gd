tool
class_name BoolBranchData
extends BranchData
var true_data setget set_true_data,get_true_data
var false_data setget set_false_data,get_false_data

func _init():
	self.unique_id = "bool"
	self.display_name = "Bool"
	self.category = "Branch"
	self.description = "对错分支"

func set_true_data(data):
	set_data("true",data)
	
func set_false_data(data):
	set_data("false",data)

func get_true_data():
	return get_data("true")
	
func get_false_data():
	return get_data("false")

func get_data(key):
	match key:
		"true","false":
			return next_data[key]
		_:
			assert(false)
	
func get_next_data():
	if run_condition():
		return get_true_data()
	else:
		return get_false_data()
	
