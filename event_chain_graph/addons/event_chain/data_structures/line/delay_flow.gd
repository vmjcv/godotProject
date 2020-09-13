tool
class_name DelayFlowLineData
extends LineData

var delay_time

func _init():
	self.unique_id = "delay_flow"
	self.display_name = "DelayFlow"
	self.category = "Line"
	self.description = "延迟流程线"
