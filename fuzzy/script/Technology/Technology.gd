class_name Technology
extends Button
# 单个科技，包含类别，等级值，前置升级条件，科技介绍，科技出现权重值（参考群星），
signal technology_click
var technlogy_type:Array setget ,get_technology_type # 科技类别：分别血统，魔法，科学
var number:int # 编号
var rank:int setget ,get_rank # 段位值，同一段位可拥有的科技是有一定数量的。
var precondition:Array setget ,get_precondition # 前置条件，为一个数组
var description:String # 科技描述
var weights:float setget ,get_weights# 权重值
var UI_path:String # ui地址
var base_bonus:Array # 基础加成值，格式,[[1,5%,0],[2,0%,30]],第一位为加成类别编号分为百分比加成和数值加成，首先计算数值加成，再计算百分比加成
var special_bonus:Array # 特殊加成值，根据加成buff数值索引加成信息，调用加成信息函数。
var RD_events_bonus:Array # 特殊事件加成，根据事件数值索引事件信息，调用事件函数。
var RD_events:Array # 可被完成的特殊事件，完成特殊事件获得一次加成
var all_progress:float # 所需全部研发点

var level:int # 等级值
var appear:int setget set_appear,get_appear # 已出现次数
var now_progress:float # 目前研发进度
var RD_bonus:bool # 完成特殊目的达成研发进度加成
var start:bool # 已开始研发
var finish:bool setget ,get_finish # 已研发完成
var select_technology_type:int setget set_select_technology_type,get_select_technology_type # 将科技选定的类型

var display_info:int setget ,display_info_get

func _init():
	pass
	
func _ready():
	connect("technology_click", TechnologyManage, "set_now_click_technology")
	connect("pressed", self, "_on_click")
	pass

func _on_click():
	emit_signal("technology_click",self)

func _get_table():
	return configs.get_table_configs(configs.technology_infoData)

func _get_table_number(technlogy_number):
	var table=_get_table()
	for k in table:
		if k.number == technlogy_number:
			return k
	return null

func update_info(technlogy_number):
	var technlogy_info = _get_table_number(technlogy_number)
	technlogy_type = technlogy_info.technlogy_type
	number = technlogy_info.number
	rank = technlogy_info.rank
	precondition = technlogy_info.precondition
	description = technlogy_info.description
	weights = technlogy_info.weights
	UI_path = technlogy_info.UI_path
	base_bonus = technlogy_info.base_bonus
	special_bonus = technlogy_info.special_bonus
	RD_events = technlogy_info.RD_events
	RD_events_bonus = technlogy_info.RD_events_bonus
	all_progress = technlogy_info.all_progress
	
	var load_dict = PlayerArchive.get_technology(technlogy_number)
	load_object(load_dict)
	
	update_icon()
	return self

func update_icon():
	icon = load(UI_path)
	return 

func display_info_get() -> int:
	if start:
		return Global.TechnologyBGType.PROGRESS
	if finish:
		return Global.TechnologyBGType.FINISH
	return Global.TechnologyBGType.NORMAL
	
func check_optional() -> Array:
	if start:
		return [false,Global.DisplayType.PROCESSING]
	if finish:
		return [false,Global.DisplayType.FINISH]
	return [true,Global.DisplayType.NULL]	

func add_progress(value) -> Array:
	var remaining = now_progress + value - all_progress
	if remaining >= 0:
		now_progress = all_progress
		start = false
		finish = true
		return [true,remaining]
	else:
		now_progress = now_progress + value
		return [false,0]

func get_technology_type():
	return technlogy_type

func set_appear(value):
	appear = value

func get_appear():
	return appear

func add_appear():
	appear = appear+1
	
func get_finish():
	return finish
	
func set_select_technology_type(value):
	select_technology_type=value

func get_select_technology_type():
	return select_technology_type	
	
func get_precondition():
	return precondition
	
func get_rank():
	return rank
	
func get_weights():
	# 获取出现次数加成后的权重值
	
	return weights*pow(0.5,get_appear())
	
func save_object():
	var save_dict = {
		"level" : level,
		"appear" : appear,
		"now_progress" : now_progress,
		"RD_bonus" : RD_bonus,
		"start" : start,
		"finish" : finish,
		"select_technology_type" : select_technology_type
	}
	return save_dict

func load_object(load_dict):
	if load_dict == null:
		load_dict = {}
	level = load_dict.get("level") if load_dict.get("level") else 0
	appear = load_dict.get("appear") if load_dict.get("appear") else 0
	now_progress = load_dict.get("now_progress") if load_dict.get("now_progress") else 0
	RD_bonus = load_dict.get("RD_bonus") if load_dict.get("RD_bonus") else false
	start = load_dict.get("start") if load_dict.get("start") else false
	finish = load_dict.get("finish") if load_dict.get("finish") else false
	select_technology_type = load_dict.get("select_technology_type") if load_dict.get("select_technology_type") else 0

