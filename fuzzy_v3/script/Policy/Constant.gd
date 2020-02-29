extends Node

enum Tendency {
	NORMAL, # 无政策
	RADICAL, # 激进政策
	NEUTRAL, # 中性政策
	CONSERVATIVE, # 保守政策
}

enum SlotShow {
	NORMAL, # 无政策在格子中
	RADICAL, # 激进政策
	NEUTRAL, # 中性政策
	CONSERVATIVE, # 保守政策
	NOSHOW, # 不显示
}

var MAX_NUMBER = configs.get_table_configs(configs.policy_infoData).size()

