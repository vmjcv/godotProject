extends Button

# 科技槽位类

var category
var rank
var id # 在当前阶的序号

var styles_box = {
	TechnologyConstant.SlotShow.PRECONDITION:{
		1:preload("res://images/styleboxflat/precondition.tres"),
		2:preload("res://images/styleboxflat/precondition.tres"),
		3:preload("res://images/styleboxflat/precondition.tres"),
		4:preload("res://images/styleboxflat/precondition.tres"),
		5:preload("res://images/styleboxflat/precondition.tres"),
		6:preload("res://images/styleboxflat/precondition.tres"),
		},
	TechnologyConstant.SlotShow.NORMAL:preload("res://images/styleboxflat/normal.tres"),
	TechnologyConstant.SlotShow.USEABLE:preload("res://images/styleboxflat/useable.tres"),
	TechnologyConstant.SlotShow.FINISH:preload("res://images/styleboxflat/finish.tres"),
	TechnologyConstant.SlotShow.PROPEL:preload("res://images/styleboxflat/propel.tres"),
	TechnologyConstant.SlotShow.NOSPACE:preload("res://images/styleboxflat/nospace.tres")
}

func _init():
	pass

func _ready():
	pass

func update_styles():
	var result_style
	var technology_node = get_node_or_null("Icon")
	var result_box
	if technology_node:
		result_style = TechnologyManage.slot_show_map[technology_node.number]
		if result_style[0] == TechnologyConstant.SlotShow.PRECONDITION:
			result_box = styles_box[TechnologyConstant.SlotShow.PRECONDITION][result_style[1]]
		else:
			result_style = result_style[0]
			result_box = styles_box[result_style]
	else:
		result_style = TechnologyConstant.SlotShow.NORMAL
		if TechnologyManage.now_select_technology:
			if category in TechnologyManage.now_select_technology.category:
				if rank == TechnologyManage.now_select_technology.rank:
					if TechnologyManage.now_select_technology.in_tree:
						result_style=TechnologyConstant.SlotShow.USEABLE
					else:
						if TechnologyManage._have_round_start_number():
							result_style=TechnologyConstant.SlotShow.USEABLE
						else:
							result_style = TechnologyConstant.SlotShow.NOSPACE
		result_box = styles_box[result_style]

	add_stylebox_override("hover",result_box)
	add_stylebox_override("pressed",result_box)
	add_stylebox_override("focus",result_box)
	add_stylebox_override("disabled",result_box)
	add_stylebox_override("normal",result_box)


