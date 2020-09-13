tool
class_name ReferenceLineData
extends LineData

var source_data
var target_data

func _init():
	self.unique_id = "reference"
	self.display_name = "Reference"
	self.category = "Line"
	self.description = "引用线"
