tool
class_name MatchBranchData
extends BranchData


func _init():
	self.unique_id = "match"
	self.display_name = "Match"
	self.category = "Branch"
	self.description = "多选择分支"

func get_next_data():
	var run_result = run_condition()
	return get_data(run_result)

