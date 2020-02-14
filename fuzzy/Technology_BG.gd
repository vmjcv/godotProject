extends Button
var technology_type
var rank
var technology_object setget set_technology_object,get_technology_object

var styles_box={
	Global.TechnologyBGType.PRECONDITION:{
		1:preload("res://images/styleboxflat/precondition.tres"),
		2:preload("res://images/styleboxflat/precondition.tres"),
		3:preload("res://images/styleboxflat/precondition.tres"),
		4:preload("res://images/styleboxflat/precondition.tres"),
		5:preload("res://images/styleboxflat/precondition.tres"),
		6:preload("res://images/styleboxflat/precondition.tres"),
		},
	Global.TechnologyBGType.NORMAL:preload("res://images/styleboxflat/normal.tres"),
	Global.TechnologyBGType.USEABLE:preload("res://images/styleboxflat/useable.tres"),
	Global.TechnologyBGType.FINISH:preload("res://images/styleboxflat/finish.tres"),
	Global.TechnologyBGType.PROGRESS:preload("res://images/styleboxflat/progress.tres")
}

func _init():
	pass

func _ready():
	pass

func set_technology_object(value):
	technology_object = value

func get_technology_object():
	return technology_object

func update_styles():
	print("44444444444")
	var result_style
	var technology_node = get_node_or_null("Icon")
	if technology_node:
		result_style = TechnologyManage.bg_type_map[technology_node.number]
		if result_style[0] == Global.TechnologyBGType.PRECONDITION:
			result_style = styles_box[Global.TechnologyBGType.PRECONDITION][result_style[1]]
		else:
			result_style = result_style[0]
	else:
		result_style = Global.TechnologyBGType.NORMAL
		if technology_type in TechnologyManage.now_click_technology.technlogy_type:
			if rank == TechnologyManage.now_click_technology.rank:
				result_style=Global.TechnologyBGType.USEABLE
	print(result_style)
	print(styles_box[result_style])
	add_stylebox_override("hover",styles_box[result_style])
	add_stylebox_override("pressed",styles_box[result_style])
	add_stylebox_override("focus",styles_box[result_style])
	add_stylebox_override("disabled",styles_box[result_style])
	add_stylebox_override("normal",styles_box[result_style])
	pass

