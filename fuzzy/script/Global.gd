extends Node

enum TechnologyType {
	DESCENT,
	SCIENCE,
	MAGIC,
}

enum DisplayType {
	APPEARED, # 已出现的无法再出现
	PROCESSING, # 研发进行中
	FINISH, # 研发已完成
	PRECONDITION_FALSE,#前置条件无法满足
	NULL, # 未知状况
}

var technology_info


