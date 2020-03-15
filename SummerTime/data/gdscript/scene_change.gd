# Tool generated file DO NOT MODIFY
tool

class scene_changeData:
	var description: String
	var down: int
	var left: int
	var number: int
	var right: int
	var up: int
	func _init(p_description, p_down, p_left, p_number, p_right, p_up):
		description = p_description
		down = p_down
		left = p_left
		number = p_number
		right = p_right
		up = p_up

static func load_configs():
	return [
		scene_changeData.new("教室", 2, -1, 1, 4, -1),
		scene_changeData.new("讲台", -1, -1, 2, -1, 1),
		scene_changeData.new("教室门口", -1, 4, 3, -1, -1),
		scene_changeData.new("公告栏", -1, 1, 4, 3, -1),
		scene_changeData.new("课桌", -1, -1, 5, -1, -1),
	]
