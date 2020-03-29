extends Control

# 政策树ui加载类，只处理跟ui相关的逻辑，不存储政策数据等信息
signal begin_one_policy
signal use_one_policy

var data = preload("res://scene/Policy/Data.tscn")
var slot = preload("res://scene/Policy/Slot.tscn")
var buff = preload("res://scene/Policy/Buff.tscn")

onready var Begin = get_node("BaseContainer/PolicyInfo/ProgressBar/HBoxContainer/Begin")
onready var Use = get_node("BaseContainer/PolicyInfo/ProgressBar/HBoxContainer/Use")
onready var Policy_Progress = get_node("BaseContainer/PolicyInfo/ProgressBar/HBoxContainer/PolicyProgress")


onready var Tree_Grid = get_node("BaseContainer/Tree/TreePanel/GridPanel")

onready var Propel_Slot = get_node("BaseContainer/Tree/GlobalInfoPanel/PropelPanel/PropelSlot")


onready var Title = get_node("BaseContainer/PolicyInfo/Description/VBoxContainer/HBoxContainer/Title")

onready var Description = get_node("BaseContainer/PolicyInfo/Description/VBoxContainer/HBoxContainer2/Description")

onready var BuffPanel = get_node("BaseContainer/PolicyInfo/Bonus/VBoxContainer2")


var Global_PropelPolicy
onready var Global_PropelTitle = get_node("BaseContainer/Tree/GlobalInfoPanel/PropelPanel/PropelTitle")
onready var Global_PropelSlot = get_node("BaseContainer/Tree/GlobalInfoPanel/PropelPanel/PropelSlot")
onready var Global_Progress = get_node("BaseContainer/Tree/GlobalInfoPanel/PropelPanel/PolicyProgress")



func _ready():
	_init_signal()
	_init_tree_slot()
	
	_init_finish_policy()
	_init_propel_policy()
	_init_selected_pool_policy()
	
	_init_global_proprl_policy()
	# 测试代码
	_start_round()

func _init_signal():
	PolicyManage.connect("up", self, "_up")
	PolicyManage.connect("begin_policy", self, "_begin_policy")
	PolicyManage.connect("use_policy", self, "_use_policy")
	PolicyManage.connect("start_round", self, "_start_round")
	PolicyManage.connect("end_round", self, "_end_round")
	PolicyManage.connect("clear_now_select", self, "_clear_now_select")
	
	connect("begin_one_policy",PolicyManage,"begin_one_policy")
	connect("use_one_policy",PolicyManage,"use_one_policy")
	pass
	
func _init_global_proprl_policy():
	Global_PropelPolicy = PolicyManage.policy_scene.instance()
	Global_PropelSlot.clear_policy()
	Global_PropelSlot.add_policy(Global_PropelPolicy)
	PolicyManage._registered_policy_signal(Global_PropelPolicy)

func get_slot(tree_id):
	return Tree_Grid.get_node("slot%s"%tree_id)
	

func _start_round():
	_update_all_slot()
	_update_propel()
	
func _end_round():
	_update_all_slot()
	_update_propel()
	
func _update_propel():
	if Global_PropelPolicy:
		var policy = PolicyManage.get(Global_PropelPolicy)
		if policy:
			Global_Progress.value=policy.now_RD_progress
			if policy.finish:
				_init_global_proprl_policy()
				Global_Progress.value=0
				Global_PropelTitle.text=""
	
func _update_all_slot():
	# 更新所有槽位的背景
	var all_slot = get_tree().get_nodes_in_group("PolicySlot")
	for node in all_slot:
		if node.tendency == null:
			node.show_policy(0)
		else:
			node.show_policy(node.tendency)
		node.update_styles()
	
func _add_to_tree(policy):
	var slot = get_slot(policy.tree_id)
	slot.add_policy(policy)

func _init_tree_slot():
	# 初始化树上所有的槽位
	for i in range(1,PolicyManage.all.tree_count+1):
		var slot_node = slot.instance()
		Tree_Grid.add_child(slot_node)
		slot_node.name = "slot%s"%i
		slot_node.add_to_group("PolicySlot")
		slot_node.tree_id = i

func _init_finish_policy():
	# 初始化树上已完成的政策
	var finish = PolicyManage.finish.keys()
	for number in finish:
		_add_to_tree(PolicyManage.finish.get(number))
	
func _init_propel_policy():
	# 初始化树上研发中的政策
	var propel = PolicyManage.propel.keys()
	for number in propel:
		_add_to_tree(PolicyManage.propel.get(number))

func _init_selected_pool_policy():
	# 初始化可选政策池的政策
	var selected_pool = PolicyManage.selected_pool.keys()
	for number in selected_pool:
		_add_to_tree(PolicyManage.selected_pool.get(number))

func _up(policy):
	# 按钮弹起,更新现在点击的政策信息
	if policy.tree_id==5:
		Begin.visible = false
		Use.visible = false
	elif policy.used:
		Begin.visible = false
		Use.visible = false
	elif policy.finish:
		Begin.visible = false
		Use.visible = true
	elif policy.start:
		Begin.visible = false
		Use.visible = false
	else:
		Begin.visible = true
		Use.visible = false
	Policy_Progress.max_value = policy.all_progress
	Policy_Progress.value = policy.now_RD_progress
	Title.text = policy.title
	Description.text = policy.description
	
	for node in BuffPanel.get_children():
		BuffPanel.remove_child(node)
	
	for data in policy.special_bonus:
		var buff_node = buff.instance()
		BuffPanel.add_child(buff_node)
		buff_node.get_node("BuffName").text=str(data)
		buff_node.get_node("BuffNumber").visible=false
	
	for data in policy.base_bonus:
		var buff_node = buff.instance()
		BuffPanel.add_child(buff_node)
		buff_node.get_node("BuffName").text=str(data[0])
		buff_node.get_node("BuffNumber").text=str(data[1])+"  "+str(data[2])	
	return
	
func _clear_now_select():
	Policy_Progress.max_value = 0
	Policy_Progress.value = 0
	Title.text = ""
	Description.text = ""
	Begin.visible=false
	Use.visible=false
	for node in BuffPanel.get_children():
		BuffPanel.remove_child(node)
	return


func _begin_policy(policy):
	# 开始某个政策的研发，更新进度条等数据
	_up(policy)
	Global_PropelTitle.text=policy.title
	Global_PropelPolicy.update_info(policy.number)
	Global_PropelSlot.update_styles()
	Global_Progress.max_value=policy.all_progress
	Global_Progress.value=policy.now_RD_progress
	return
	
func _use_policy(policy):
	# 使用某个政策，更新进度条等数据
	_up(policy)
	_update_all_slot()
	return

func _on_Begin_button_up():
	emit_signal("begin_one_policy")
	pass # Replace with function body.


func _on_Use_button_up():
	emit_signal("use_one_policy")
	pass # Replace with function body.
