class_name TechnologyData

extends Button

# 科技类,数据加载通过读表加载和加载玩家信息得到

signal down # 按下这个按钮的时候发出信号，目的是传递参数
signal up # 弹起这个按钮的时候发出信号，目的是传递参数

var category:Array # 科技类别：分别血统，魔法，科学 （0，1，2）
var number:int # 编号
var rank:int # 段位值，同一段位可拥有的科技是有一定数量的。
var precondition:Array	# 前置条件，为一个数组
var description:String # 科技描述
var weights:float setget ,get_weights# 权重值
var UI_path:String # ui地址
var base_bonus:Array # 基础加成值，格式,[[1,5%,0],[2,0%,30]],第一位为加成类别编号分为百分比加成和数值加成，首先计算数值加成，再计算百分比加成
var special_bonus:Array # 特殊加成值，根据加成buff数值索引加成信息，调用加成信息函数。
var event_bonus:Array # 特殊事件加成，根据事件数值索引事件信息，调用事件函数。
var gain_event:Array # 可被完成的特殊事件，完成特殊事件获得一次加成
var all_progress:float # 所需全部研发点

var level:int # 等级值
var appear_number:int # 已出现次数
var now_RD_progress:float # 现在研发进度
var now_gain_event:bool # 完成特殊目的达成研发进度加成
var start:bool # 已开始研发
var finish:bool # 已研发完成
var in_tree:bool # 是否在树上
var in_selected:bool # 是否在待选区内
var tree_category:int # 树上的显示类型
var tree_rank:int # 树上的显示阶位
var tree_rank_id:int # 树上的显示此阶序号
var slot_show:int setget ,slot_show_get # 返回当前格子的显示信息

func _init():
	pass
	
func _ready():
	var self_var = self
	
	connect("button_down", Callable(self_var,"_on_down"))
	connect("button_up", Callable(self_var,"_on_up"))
	pass

func update_info(technology_number):
	var info = _get_table_number(technology_number)
	_load_table(info)

	var load_dict = _get_object_number(technology_number)
	_load_object(load_dict)
	
	_update_icon()
	return self

func check_add_selected() -> Array:
	# 判断是否可加入待选区中,不判断前置科技是否满足
	if start:
		return [false,TechnologyConstant.AddSelected.PROPEL]
	if finish:
		return [false,TechnologyConstant.AddSelected.FINISH]
	return [true,TechnologyConstant.AddSelected.DISRD]	

func add_progress(value) -> Array:
	var remaining = now_RD_progress + value - all_progress
	if remaining >= 0:
		now_RD_progress = all_progress
		start = false
		finish = true
		return [true,remaining]
	else:
		now_RD_progress = now_RD_progress + value
		return [false,0]

func add_appear_number():
	# 增加当前的次数
	appear_number = appear_number + 1
	
func save_object():
	# 保存存档信息
	var save_dict = {
		"level" : level,
		"appear_number" : appear_number,
		"now_RD_progress" : now_RD_progress,
		"now_gain_event" : now_gain_event,
		"start" : start,
		"finish" : finish,
		"in_tree" : in_tree,
		"in_selected" : in_selected,
		"tree_category" : tree_category,
		"tree_rank" : tree_rank,
		"tree_rank_id" : tree_rank_id,
	}
	return save_dict


func _on_down():
	emit_signal("down",self)

func _on_up():
	emit_signal("up",self)

func _update_icon():
	icon = load(UI_path)
	return 

func get_weights():
	# 获取出现次数加成后的权重值
	return weights*pow(0.5,appear_number)
	
func slot_show_get() -> int:
	if start:
		return TechnologyConstant.SlotShow.PROPEL
	if finish:
		return TechnologyConstant.SlotShow.FINISH
	return TechnologyConstant.SlotShow.NORMAL

func _get_table():
	return Configs.get_table_configs(Configs.technology_infoData)

func _get_table_number(technology_number):
	var table = _get_table()
	for data in table:
		if data.number == technology_number:
			return data
	return null

func _get_object_number(technology_number):
	return PlayerArchive.get_technology(technology_number)
	
func _load_table(load_dict):
	category = load_dict.category
	number = load_dict.number
	rank = load_dict.rank
	precondition = load_dict.precondition
	description = load_dict.description
	weights = load_dict.weights
	UI_path = load_dict.UI_path
	base_bonus = load_dict.base_bonus
	special_bonus = load_dict.special_bonus
	event_bonus = load_dict.event_bonus
	gain_event = load_dict.gain_event
	all_progress = load_dict.all_progress	
	
func _load_object(load_dict):
	# 加载保存的信息
	if load_dict == null:
		load_dict = {}
	level = load_dict.get("level") if load_dict.get("level") else 0
	appear_number = load_dict.get("appear_number") if load_dict.get("appear_number") else 0
	now_RD_progress = load_dict.get("now_RD_progress") if load_dict.get("now_RD_progress") else 0
	now_gain_event = load_dict.get("now_gain_event") if load_dict.get("now_gain_event") else false
	start = load_dict.get("start") if load_dict.get("start") else false
	finish = load_dict.get("finish") if load_dict.get("finish") else false
	in_tree = load_dict.get("in_tree") if load_dict.get("in_tree") else false
	in_selected = load_dict.get("in_selected") if load_dict.get("in_selected") else false
	tree_category = load_dict.get("tree_category") if load_dict.get("tree_category") else 0
	tree_rank = load_dict.get("tree_rank") if load_dict.get("tree_rank") else 0
	tree_rank_id = load_dict.get("tree_rank_id") if load_dict.get("tree_rank_id") else 0
