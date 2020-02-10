class_name Technology
extends Node
# 单个科技，包含类别，等级值，前置升级条件，科技介绍，科技出现权重值（参考群星），

var technlogy_type:int # 科技类别：分别血统，魔法，科学
var number:int # 编号
var rank:int # 段位值，同一段位可拥有的科技是有一定数量的。
var precondition:Array # 前置条件，为一个数组
var description:String # 科技描述
var weights:float # 权重值
var UI_path:String # ui地址
var base_bonus:Array # 基础加成值，格式,[[5%,0],[0%,30]],分为百分比加成和数值加成，首先计算数值加成，再计算百分比加成
var special_bonus:Array # 特殊加成值，根据加成buff数值索引加成信息，调用加成信息函数。
var RD_events:Array # 特殊事件，根据事件数值索引事件信息，调用事件函数。

var level:int # 等级值
var appear:bool # 已出现
var now_progress:float # 目前研发进度
var all_progress:float # 所需全部研发点
var RD_bonus:bool # 完成特殊目的达成研发进度加成
var start:bool # 已开始研发
var finish:bool # 已研发完成

var display_info:Array setget ,display_info_get


func _init(technlogy_number):
	var technlogy_info = Global.technology_info.get_info(technlogy_number)
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
	
	var player_info = Global.player_info.get_technology(technlogy_number)
	level = player_info.level
	appear = player_info.appear
	now_progress = player_info.now_progress
	all_progress = player_info.all_progress
	RD_bonus = player_info.RD_bonus
	start = player_info.start
	finish = player_info.finish
	
	
func display_info_get() -> Array:
	if appear:
		return [false,Global.DisplayType.APPEARED]
	if start:
		return [true,Global.DisplayType.PROCESSING]
	if finish:
		return [true,Global.DisplayType.FINISH]
	return [false,Global.DisplayType.NULL]
	
func add_progress(value) -> Array:
	var remaining = now_progress + value - all_progress
	if remaining>=0:
		now_progress = all_progress
		start = false
		finish = true
		return [true,remaining]
	else:
		now_progress = now_progress + value
		return [false,0]















