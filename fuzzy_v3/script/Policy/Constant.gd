extends Node

enum Tendency {
	TAOISM, # 道家
	MOHIST, # 墨家
	CONFUCIANISM, # 儒家
	LEGALIST, # 法家
}

enum SlotShow {
	TAOISM, # 道家
	MOHIST, # 墨家
	CONFUCIANISM, # 儒家
	LEGALIST, # 法家
	NOSHOW, # 不显示
}

var MAX_NUMBER = configs.get_table_configs(configs.policy_infoData).size()

