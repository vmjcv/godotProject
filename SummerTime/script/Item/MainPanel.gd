extends Control

# 道具ui加载类，只处理跟ui相关的逻辑，不存储道具数据等信息

signal to_other
signal to_own_pool
signal mouse_click

signal close_item_info
signal show_item_info

var data = preload("res://scene/Item/Data.tscn")
var slot = preload("res://scene/Item/Slot.tscn")
var item_panel = preload("res://scene/Item/ItemPanel.tscn")

onready var own_panel = get_node("OwnPanel")

func _ready():
	_init_signal()
	_init_own_slot()
	
	_init_own_pool_item()

func _init_signal():
	ItemManage.connect("own_pool_to_other", self, "_own_pool_to_other")
	ItemManage.connect("other_to_own_pool", self, "_other_to_own_pool")
	ItemManage.connect("down", self, "_down")
	ItemManage.connect("up", self, "_up")
	ItemManage.connect("close_item_info", self, "_close_item_info")	
	ItemManage.connect("show_item_info", self, "_show_item_info")
	
	connect("to_other",ItemManage,"to_other")
	connect("to_own_pool",ItemManage,"to_own_pool")
	connect("mouse_click",ItemManage,"mouse_click")


func get_slot(id):
	return get_node("OwnPanel/ItemPanel/IconPanel/Slot%s"%id)

func _own_pool_to_other(item,obj):
	# obj为道具交互的对象
	_resize_to_small(item)
	_remove_from_panrent(item)
	_update_all_slot()
	
func _other_to_own_pool(item):
	_reset_position(item)
	_resize_to_small(item)
	_remove_from_panrent(item)
	_add_own_pool(item)
	_update_all_slot()

func _update_all_slot():
	# 更新所有槽位的背景
	var all_slot = get_tree().get_nodes_in_group("ItemSlot")
	for node in all_slot:
		node.update_styles()

func _add_own_pool(item):
	for i in range(1,ItemManage.own_max_number+1):
		var slot=get_slot(i)
		if slot.get_child_count()==0:
			slot.add_child(item)
			break

func _resize_to_big(item):
	item.rect_min_size = Vector2(80,80)
	item.rect_size = Vector2(80,80)
	item.get_node("Area2D/CollisionShape2D").shape.extents=Vector2(80,80)

func _resize_to_small(item):
	item.rect_min_size = Vector2(60,60)
	item.rect_size = Vector2(60,60)
	item.get_node("Area2D/CollisionShape2D").shape.extents=Vector2(60,60)

func _reset_position(item):
	item.rect_position = Vector2(0,0)


func _remove_from_panrent(item):
	item.get_parent().remove_child(item)
	
func _init_own_slot():
	# 初始化道具栏上所有的槽位
	var node = item_panel.instance()
	node.name="ItemPanel"
	own_panel.add_child(node)
	for i in range(1,ItemManage.own_max_number+1):
		var slot_node = slot.instance()
		slot_node.name="Slot%s"%i
		node.add_slot(slot_node,i)

func _init_own_pool_item():
	# 初始化道具栏中的道具
	var own_pool = ItemManage.own.keys()
	for number in own_pool:
		_add_own_pool(ItemManage.own.get(number))

func _up(item):
	# 按钮弹起
	_check_up_pos(item)

func _down(item):
	# 按钮按下，更新界面
	_update_all_slot()


func _check_up_pos(item):
	# 检测弹起的地方是否需要加入
	if ItemManage.own.has(item):
		_reset_position(item)
		emit_signal("to_other",item)
	else:
		emit_signal("to_own_pool",item)
	

func _process(delta):
	var now_item = ItemManage.now_select_item
	if now_item and now_item.pressed:
		var end_pos= get_global_mouse_position()
		now_item.rect_global_position = end_pos - now_item.rect_size/2

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed==false:
		emit_signal("mouse_click")


func _show_item_info(number):
	# 关键道具显示大弹框，非关键道具显示小弹框
	var object = ItemManage.get(number)
	emit_signal("show_item_info",object.description,object.UI_path,object.is_key) # 发送道具更新信号去更新ui
	pass

func _close_item_info():
	# 关键道具显示弹框
	emit_signal("close_item_info")
	pass
