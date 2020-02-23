extends Control

# 科技树ui加载类，只处理跟ui相关的逻辑，不存储科技数据等信息

signal to_propel
signal to_selected_pool

var data = preload("res://scene/Technology/Data.tscn")
var slot = preload("res://scene/Technology/Slot.tscn")
var rank_panel = preload("res://scene/Technology/RankPanel.tscn")

onready var descent = get_node("BaseContainer/ThreeTree/Descent")
onready var science = get_node("BaseContainer/ThreeTree/Science")
onready var magic = get_node("BaseContainer/ThreeTree/Magic")

onready var select_panel = get_node("BaseContainer/SelectedPanel/SelectedGridPanel")
onready var select_base_panel = get_node("BaseContainer/SelectedPanel")
	

onready var technology_tree_map = {
	TechnologyConstant.Category.DESCENT:descent,
	TechnologyConstant.Category.SCIENCE:science,
	TechnologyConstant.Category.MAGIC:magic,
}

func _ready():
	_init_signal()
	_init_tree_slot()
	
	_init_finish_technology()
	_init_propel_technology()
	_init_selected_pool_technology()

func _init_signal():
	TechnologyManage.connect("selected_pool_to_propel", self, "_selected_pool_to_propel")
	TechnologyManage.connect("propel_to_propel", self, "_propel_to_propel")
	TechnologyManage.connect("propel_to_selected_pool", self, "_propel_to_selected_pool")
	TechnologyManage.connect("selected_pool_update", self, "_selected_pool_update")
	TechnologyManage.connect("down", self, "_down")
	TechnologyManage.connect("up", self, "_up")
	TechnologyManage.connect("start_round", self, "_start_round")
	TechnologyManage.connect("end_round", self, "_end_round")
	
	
	connect("to_propel",TechnologyManage,"to_propel")
	connect("to_selected_pool",TechnologyManage,"to_selected_pool")


func get_slot(category,rank,rank_id):
	return technology_tree_map[category].get_node("Rank%s/IconPanel/Slot%s"%[rank, rank_id])
	
func get_technology(category,rank,rank_id):
	return technology_tree_map[category].get_node("Rank%s/IconPanel/Slot%s/Icon"%[rank, rank_id])

func _start_round():
	_update_all_slot()
	
func _end_round():
	_update_all_slot()

func _selected_pool_to_propel(technology):
	_resize_to_small(technology)
	_remove_from_panrent(technology)
	_add_to_tree(technology)
	_update_all_slot()

func _propel_to_propel(technology):
	_resize_to_small(technology)
	_remove_from_panrent(technology)
	_add_to_tree(technology)
	_update_all_slot()
	
func _propel_to_selected_pool(technology):
	_resize_to_big(technology)
	_remove_from_panrent(technology)
	_add_selected_pool(technology)
	_update_all_slot()

func _update_all_slot():
	# 更新所有槽位的背景
	var all_slot = get_tree().get_nodes_in_group("TechnologySlot")
	for node in all_slot:
		node.update_styles()

func _selected_pool_update():
	_remove_selected_pool()
	var selected_pool_keys = TechnologyManage.selected_pool.keys()
	for number in selected_pool_keys:
		_add_selected_pool(TechnologyManage.selected_pool.get(number))
	pass
	
func _add_selected_pool(technology):
	select_panel.add_child(technology)

func _add_to_tree(technology):
	var slot = get_slot(technology.tree_category,technology.tree_rank,technology.tree_rank_id)
	slot.add_child(technology)
	technology.name="Icon"
	technology.rect_position=Vector2(0,0)

func _resize_to_big(technology):
	technology.rect_min_size = Vector2(80,80)
	technology.rect_size = Vector2(80,80)

func _resize_to_small(technology):
	technology.rect_min_size = Vector2(60,60)
	technology.rect_size = Vector2(60,60)

func _remove_from_panrent(technology):
	technology.get_parent().remove_child(technology)
	
func _remove_selected_pool():
	for node in select_panel.get_children():
		select_panel.remove_child(node)

func _init_tree_slot():
	# 初始化树上所有的槽位
	var selected_rank_number = TechnologyManage.selected_rank_number
	for category in selected_rank_number:
		var root_node = technology_tree_map[category]
		var rank_tree = selected_rank_number[category]
		for rank in rank_tree:
			var node = rank_panel.instance()
			node.name="Rank%s"%rank
			root_node.add_child(node)
			for i in range(1,rank_tree[rank]+1):
				var slot_node = slot.instance()
				slot_node.rect_min_size = Vector2(60,60)
				slot_node.rect_size = Vector2(60,60)
				node.get_node("IconPanel").add_child(slot_node)
				slot_node.name="Slot%s"%i
				slot_node.add_to_group("TechnologySlot")
				slot_node.category=category
				slot_node.rank=rank
				slot_node.id=i

func _init_finish_technology():
	# 初始化树上已完成的科技
	var finish = TechnologyManage.finish.keys()
	for number in finish:
		_add_to_tree(TechnologyManage.finish.get(number))
	
func _init_propel_technology():
	# 初始化树上研发中的科技
	var propel = TechnologyManage.propel.keys()
	for number in propel:
		_add_to_tree(TechnologyManage.propel.get(number))

func _init_selected_pool_technology():
	# 初始化可选科技池的科技
	var selected_pool = TechnologyManage.selected_pool.keys()
	for number in selected_pool:
		_add_selected_pool(TechnologyManage.selected_pool.get(number))

func _up(technology):
	# 按钮弹起
	$BezierCurve.visible = false
	_check_up_pos(technology)

func _down(technology):
	# 按钮按下，更新界面
	_update_all_slot()
	_beziercurve_init(technology)
	$BezierCurve.visible = true
	
func _beziercurve_init(technology):
	# 初始化贝塞尔曲线
	var start_pos = technology.rect_global_position
	start_pos=start_pos+technology.rect_size/2
	var end_pos= start_pos
	$BezierCurve.reset(start_pos,end_pos)

func _check_up_pos(technology):
	# 检测弹起的地方是否需要加入
	var all_slot=get_tree().get_nodes_in_group("TechnologySlot")
	var add_result = false
	for slot in all_slot:
		var size = slot.rect_size
		var local_position=slot.get_local_mouse_position()
		if 0<=local_position.x and local_position.x<=size.x and 0<=local_position.y and local_position.y<=size.y:
			# 是移到科技树槽位弹起
			emit_signal("to_propel",technology,slot)
			add_result=true
			break
	if not add_result:
		# 如果加到了科技树中就不用管了
		var size = select_base_panel.rect_size
		var local_position=select_base_panel.get_local_mouse_position()
		if 0<=local_position.x and local_position.x<=size.x and 0<=local_position.y and local_position.y<=size.y:
			# 是移到待选格弹起
			emit_signal("to_selected_pool",technology)

func _process(delta):
	if TechnologyManage.now_select_technology and TechnologyManage.now_select_technology.pressed:
		var start_pos = TechnologyManage.now_select_technology.rect_global_position
		start_pos = start_pos+TechnologyManage.now_select_technology.rect_size/2
		var end_pos= get_global_mouse_position()
		$BezierCurve.reset(start_pos,end_pos)
	pass

