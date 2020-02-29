extends Node

enum Category {
	DESCENT,
	SCIENCE,
	MAGIC
}
enum AddSelected {
	# 是否科技加入待选科技池的信息
	PROPEL, # 研发推进中无法改变
	FINISH, # 研发
	DISRD, # 未研发
	CANSELECTED, # 可待选
	RANK_FULL, # 阶位已满
	DISPRECONDITION # 前置条件无法满足
}

enum SlotShow {
	PRECONDITION, # 前置科技
	NORMAL, # 无科技在槽位内
	USEABLE, # 可使用的空白槽位
	FINISH, # 已研发完成科技
	PROPEL, # 科技研发推进中
	NOSPACE # 无当前回合研发空位
}

var MAX_NUMBER = Configs.get_table_configs(Configs.technology_infoData).size()

