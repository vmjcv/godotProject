tool
class_name LineData
extends EventChainData

var prev_data # 前置节点
var next_data # 后置节点

func _init():
	self.unique_id = "line_data"
	self.display_name = "LineData"
	self.category = "Line"
	self.description = "Process line"
