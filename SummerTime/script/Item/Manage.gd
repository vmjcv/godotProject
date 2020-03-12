extends Node

# 道具管理类，非道具类调用道具内容只能通过manage进行调用

signal own_pool_to_other
signal other_to_own_pool
signal down
signal up

var all:ItemTable # 所有道具
var own:ItemTable # 已拥有道具
var other:ItemTable # 场景中道具
var now_select_item:ItemData # 当前选择道具
var now_mouse_entered_item # 当前选中区域
var own_max_number  setget ,get_own_max_number

var item_scene = preload("res://scene/Item/Data.tscn")

func _init():
	_load_object(PlayerArchive.get_item_manage())
	pass
	
func _clear_now_select_item():
	now_select_item = null

func get_own_max_number():
	return ItemConstant.MAX_NUMBER

func to_other(item):
	if own.has(item):
		check_own_pool_to_other(item)
	else:
		pass

func to_own_pool(item):
	if own.has(item):
		pass
	else:
		check_other_to_own_pool(item)
	
func check_own_pool_to_other(item):
	# 检测道具是否可以与场景物体交互
	if self.now_mouse_entered_item:
		if item.number==self.now_mouse_entered_item.number:
			_own_pool_to_other(item,self.now_mouse_entered_item)
		pass

func check_other_to_own_pool(item):
	# 检测是否可以获得场景道具
	_other_to_own_pool(item)


func _own_pool_to_other(item,obj):
	# 将道具从道具栏与场景物体交互
	own.erase(item)
	emit_signal("own_pool_to_other",item,obj) # 发送道具更新信号去更新ui
	pass

	
func _other_to_own_pool(item):
	# 将道具从场景移动到道具栏中
	own.append(item)
	other.erase(item)
	emit_signal("other_to_own_pool",item) # 发送道具更新信号去更新ui
	pass

func get(number):
	return all.get(number)

func save_object():
	var save_dict = {
		"all" : all.get_all().keys(),
		"own" : own.get_all().keys(),
		"other" : other.get_all().keys()
	}
	return save_dict

func _load_object(load_dict):
	if load_dict == null:
		load_dict = {}
	var all_table = load_dict.get("all",Array(range(1,ItemConstant.MAX_NUMBER+1)))
	all=ItemTable.new(null)
	for number in all_table:
		var item = item_scene.instance()
		item.update_info(number)
		all.append(item)
		_registered_item_signal(item)
	var own_table = load_dict.get("own",[])
	own=ItemTable.new(null)
	for number in own_table:
		own.append(all.get(number))
	var other_table = load_dict.get("other",[])
	other=ItemTable.new(null)
	for number in other_table:
		other.append(all.get(number))

func _registered_item_signal(item):
	item.connect("down", self, "_down_item_button")
	item.connect("up", self, "_up_item_button")
	
func _down_item_button(item):
	if own.has(item):
		now_select_item = item
	else:
		pass
	emit_signal("down",item)
	pass

func _up_item_button(item):
	emit_signal("up",item)
	pass
	
func area_entered(item):
	now_mouse_entered_item = item
	pass

func area_exited(item):
	if now_mouse_entered_item==item:
		now_mouse_entered_item=null
	pass
