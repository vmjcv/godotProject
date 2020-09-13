tool
class_name BranchData
extends EventChainData

var prev_data # 前置节点
var next_data:Dictionary # 后置节点

var condition setget set_condition,get_condition

func _ready():
	unique_id = "branch_data"
	display_name = "BranchData"
	category = "Branch"
	description = "Branch options"

func set_data(key,data):
	next_data[key] = data

func get_data(key):
	return next_data[key]

func set_condition(string):
	condition = string
	
func get_condition():
	return condition


func run_condition():
	return true

func get_next_data():
	return true
	
	
	
	
