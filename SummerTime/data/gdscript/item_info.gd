# Tool generated file DO NOT MODIFY
tool

class item_infoData:
	var UI_path: String
	var description: String
	var number: int
	func _init(p_UI_path, p_description, p_number):
		UI_path = p_UI_path
		description = p_description
		number = p_number

static func load_configs():
	return [
		item_infoData.new("res://images/icon/item/Item_00001.png", "道具1", 1),
		item_infoData.new("res://images/icon/item/Item_00002.png", "道具2", 2),
		item_infoData.new("res://images/icon/item/Item_00003.png", "道具3", 3),
		item_infoData.new("res://images/icon/item/Item_00004.png", "道具4", 4),
		item_infoData.new("res://images/icon/item/Item_00005.png", "道具5", 5),
		item_infoData.new("res://images/icon/item/Item_00006.png", "道具6", 6),
		item_infoData.new("res://images/icon/item/Item_00007.png", "道具7", 7),
		item_infoData.new("res://images/icon/item/Item_00008.png", "道具8", 8),
		item_infoData.new("res://images/icon/item/Item_00009.png", "道具9", 9),
		item_infoData.new("res://images/icon/item/Item_00010.png", "道具10", 10),
	]
