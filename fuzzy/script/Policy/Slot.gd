extends Button

# 科技槽位类

var tendency:int 
var id:int # 在树上的显示序号
var slot_group # 旗下的按钮组

var styles_box = {
	PolicyConstant.SlotShow.NORMAL:preload("res://images/styleboxflat/normal_round.tres"),
	PolicyConstant.SlotShow.RADICAL:preload("res://images/styleboxflat/radical_round.tres"),
	PolicyConstant.SlotShow.NEUTRAL:preload("res://images/styleboxflat/neutral_round.tres"),
	PolicyConstant.SlotShow.CONSERVATIVE:preload("res://images/styleboxflat/conservative_round.tres"),
	PolicyConstant.SlotShow.NOSHOW:preload("res://images/styleboxflat/noshow_round.tres")
}

func _init():
	slot_group = ButtonGroup.new()
	pass

func _ready():
	pass
	
func update_styles():
	var result_style = PolicyConstant.SlotShow.NOSHOW
	var result_box
	var policy_array = get_children()
	
	for policy_node in policy_array:
		if policy_node.slot_show == result_style:
			pass
		else:
			result_style = policy_node.slot_show
			break
	
	result_box = styles_box[result_style]

	add_stylebox_override("hover",result_box)
	add_stylebox_override("pressed",result_box)
	add_stylebox_override("focus",result_box)
	add_stylebox_override("disabled",result_box)
	add_stylebox_override("normal",result_box)


