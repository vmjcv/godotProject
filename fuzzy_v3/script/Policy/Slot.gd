extends Button

# 政策槽位类

var tendency:int 
var tree_id:int # 在树上的显示序号
var slot_group # 旗下的按钮组
onready var left = get_node("Left_Right/Left")
onready var right = get_node("Left_Right/Right")

var styles_box = {
	PolicyConstant.SlotShow.TAOISM:preload("res://images/styleboxflat/normal_round.tres"),
	PolicyConstant.SlotShow.MOHIST:preload("res://images/styleboxflat/radical_round.tres"),
	PolicyConstant.SlotShow.CONFUCIANISM:preload("res://images/styleboxflat/neutral_round.tres"),
	PolicyConstant.SlotShow.LEGALIST:preload("res://images/styleboxflat/conservative_round.tres"),
	PolicyConstant.SlotShow.NOSHOW:preload("res://images/styleboxflat/noshow_round.tres")
}

func _init():
	slot_group = ButtonGroup.new()
	pass

func _ready():
	update_styles()
	pass
	
func update_styles():
	var result_style = PolicyConstant.SlotShow.NOSHOW
	var result_box
	var policy_array = slot_group.get_buttons()
	
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
	
	if slot_group.get_buttons().size()<=1:
		left.visible=false
		right.visible=false
	else:
		left.visible=true
		right.visible=true

func add_policy(policy_node):
	var parent = policy_node.get_parent()
	if parent:
		parent.remove_child(policy_node)
	get_node("PolicyContainer").add_child(policy_node)
	policy_node.name = "Policy%s"%policy_node.tendency
	policy_node.set_button_group(slot_group)
	
func clear_policy():
	for policy in slot_group.get_buttons():
		get_node("PolicyContainer").remove_child(policy)

func show_policy(number):
	tendency = number
	for policy in slot_group.get_buttons():
		policy.visible = false
	get_node("PolicyContainer/Policy%s"%number).visible=true


func _on_left_button_up():
	var tendency_size = PolicyConstant.Tendency.size() 
	tendency = (tendency -1 + tendency_size) % tendency_size
	show_policy(tendency)


func _on_right_button_up():
	var tendency_size = PolicyConstant.Tendency.size() 
	tendency = (tendency  +1 + tendency_size) % tendency_size
	show_policy(tendency)
