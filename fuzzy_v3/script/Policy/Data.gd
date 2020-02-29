class_name PolicyData

extends Button

# 政策类,数据加载通过读表加载和加载玩家信息得到

signal up # 弹起这个按钮的时候发出信号，目的是传递参数

var styles_box = {
	PolicyConstant.Tendency.NORMAL:preload("res://images/styleboxflat/normal_round.tres"),
	PolicyConstant.Tendency.RADICAL:preload("res://images/styleboxflat/radical_round.tres"),
	PolicyConstant.Tendency.NEUTRAL:preload("res://images/styleboxflat/neutral_round.tres"),
	PolicyConstant.Tendency.CONSERVATIVE:preload("res://images/styleboxflat/conservative_round.tres")
}

var tree_id:int # 树上的显示序号，即编注是第几个格子
var tendency:int # 政策倾向：无，激进，中性，保守 （0，1，2，3）
var number:int # 编号
var description:String # 政策描述
var UI_path:String # ui地址
var base_bonus:Array # 基础加成值，格式,[[1,5%,0],[2,0%,30]],第一位为加成类别编号分为百分比加成和数值加成，首先计算数值加成，再计算百分比加成
var special_bonus:Array # 特殊加成值，根据加成buff数值索引加成信息，调用加成信息函数。
var event_bonus:Array # 特殊事件加成，根据事件数值索引事件信息，调用事件函数。
var gain_event:Array # 可被完成的特殊事件，完成特殊事件获得一次加成
var all_progress:float # 所需全部研发点

var level:int # 等级值
var now_RD_progress:float # 现在研发进度
var now_gain_event:bool # 完成特殊目的达成研发进度加成
var start:bool # 已开始研发
var finish:bool setget set_finish,get_finish# 已研发完成
var used:bool # 是否在树上被使用
var slot_show:int setget ,slot_show_get # 返回当前格子的显示信息

func _init():
	pass
	
func _ready():
	connect("button_up",self,"_on_up")
	pass

func update_info(policy_number):
	var info = _get_table_number(policy_number)
	_load_table(info)

	var load_dict = _get_object_number(policy_number)
	_load_object(load_dict)
	
	_update_icon()
	return self

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
	
func save_object():
	# 保存存档信息
	var save_dict = {
		"level" : level,
		"now_RD_progress" : now_RD_progress,
		"now_gain_event" : now_gain_event,
		"start" : start,
		"finish" : finish,
		"used" : used,
	}
	return save_dict

func _on_up():
	emit_signal("up",self)

func _update_icon():
	icon = load(UI_path)
	var result_box = styles_box[tendency]
	add_stylebox_override("hover",result_box)
	add_stylebox_override("pressed",result_box)
	add_stylebox_override("focus",result_box)
	add_stylebox_override("disabled",result_box)
	add_stylebox_override("normal",result_box)
	return 
	
func slot_show_get() -> int:
	if finish and used:
		return tendency
	return PolicyConstant.SlotShow.NOSHOW

func set_finish(value):
	finish = value
	get_node("Lock").visible = not finish
	return 
	
func get_finish():
	return finish

func _get_table():
	return configs.get_table_configs(configs.policy_infoData)

func _get_table_number(policy_number):
	var table = _get_table()
	for data in table:
		if data.number == policy_number:
			return data
	return null

func _get_object_number(policy_number):
	return PlayerArchive.get_policy(policy_number)
	
func _load_table(load_dict):
	tree_id = load_dict.tree_id
	tendency = load_dict.tendency
	number = load_dict.number
	description = load_dict.description
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
	now_RD_progress = load_dict.get("now_RD_progress") if load_dict.get("now_RD_progress") else 0
	now_gain_event = load_dict.get("now_gain_event") if load_dict.get("now_gain_event") else false
	start = load_dict.get("start") if load_dict.get("start") else false
	finish = load_dict.get("finish") if load_dict.get("finish") else false
	used = load_dict.get("used") if load_dict.get("used") else false
