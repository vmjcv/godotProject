# 全局数据类
extends Node

enum TechnologyType {
	DESCENT,
	SCIENCE,
	MAGIC,
}

enum DisplayType {
	# APPEARED, # 已出现的无法再出现
	PROCESSING, # 研发进行中
	FINISH, # 研发已完成
	PRECONDITION_FALSE,#前置条件无法满足
	RANK_FULL, # 阶位中科技数量已满
	OPTIONAL, # 可待选
	NULL, # 未知状况
}
enum TechnologyBGType {
	PRECONDITION, # 当前点击科技的前置科技
	NORMAL, # 无特殊情况的正常显示
	USEABLE, # 可使用的空白槽位
	FINISH, # 已研发完成科技
	PROGRESS, # 正在研发科技
}


const RANK_MAX_NUMBER=7

const TECHNOLOGY_MAX_NUMBER = 200

func _ready():
	pass
