class_name ItemData

extends Button

# 道具类,数据加载通过读表加载和加载玩家信息得到

signal down # 按下这个按钮的时候发出信号，目的是传递参数
signal up # 弹起这个按钮的时候发出信号，目的是传递参数


export var number:int # 编号
export var all_number:int # 编号
var description:String # 道具描述
var UI_path:String # ui地址
var can_get:bool # 是否可得到
var is_key:bool # 是否是关键道具，关键道具显示大弹窗信息提示，不关键道具显示小对话框信息提示

func _init():
	pass
	
func _ready():
	connect("button_down", self, "_on_down")
	connect("button_up",self,"_on_up")
	if number:
		if ItemManage.own.has(number) and ItemManage.other.has(number):
			# 如果不在场景中也不在道具栏中说明已被使用
			self.get_parent().remove_child(self)
		else:
			update_info(number)
			ItemManage._registered_item_signal(self)
	pass

func update_info(item_number):
	var info = _get_table_number(item_number)
	_load_table(info)

	var load_dict = _get_object_number(item_number)
	_load_object(load_dict)
	
	_update_icon()
	return self

func save_object():
	# 保存存档信息
	var save_dict = {
	}
	return save_dict

func _on_down():
	emit_signal("down",self)

func _on_up():
	emit_signal("up",self)

func _update_icon():
	icon = load(UI_path)
	return

func _get_table():
	return configs.get_table_configs(configs.item_infoData)

func _get_table_number(item_number):
	var table = _get_table()
	for data in table:
		if data.number == item_number:
			return data
	return null

func _get_object_number(item_number):
	return PlayerArchive.get_item(item_number)
	
func _load_table(load_dict):
	number = load_dict.number
	description = load_dict.description
	UI_path = load_dict.UI_path
	can_get = load_dict.can_get
	is_key = load_dict.is_key

func _load_object(load_dict):
	# 加载保存的信息
	if load_dict == null:
		load_dict = {}
		
