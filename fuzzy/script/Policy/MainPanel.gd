extends Control

# 政策树ui加载类，只处理跟ui相关的逻辑，不存储政策数据等信息

var data = preload("res://scene/Policy/Data.tscn")
var slot = preload("res://scene/Policy/Slot.tscn")

onready var Tree_Grid = get_node("BaseContainer/Tree/TreePanel/GridPanel")

onready var Propel_Slot = get_node("BaseContainer/Tree/GlobalInfoPanel/PropelPanel/PropelSlot")


func _ready():
	_init_signal()
	_init_tree_slot()
	
	_init_finish_policy()
	_init_propel_policy()
	_init_selected_pool_policy()
	
	# 测试代码
	_start_round()

func _init_signal():
	PolicyManage.connect("up", self, "_up")
	pass

func get_slot(tree_id):
	return Tree_Grid.get_node("slot%s"%tree_id)
	

func _start_round():
	_update_all_slot()
	
func _end_round():
	_update_all_slot()
	
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
	print("11111111111111")
	return
