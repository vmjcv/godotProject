# Tool generated file DO NOT MODIFY
tool

class item_infoData:
	var UI_path: String
	var can_get: bool
	var description: String
	var is_key: bool
	var number: int
	func _init(p_UI_path, p_can_get, p_description, p_is_key, p_number):
		UI_path = p_UI_path
		can_get = p_can_get
		description = p_description
		is_key = p_is_key
		number = p_number

static func load_configs():
	return [
		item_infoData.new("res://images/icon/item/Item_00001.png", true, "道具1", true, 1),
		item_infoData.new("res://images/icon/item/Item_00002.png", true, "道具2", true, 2),
		item_infoData.new("res://images/icon/item/Item_00003.png", true, "道具3", true, 3),
		item_infoData.new("res://images/icon/item/Item_00004.png", true, "道具4", true, 4),
		item_infoData.new("res://images/icon/item/Item_00005.png", true, "道具5", true, 5),
		item_infoData.new("res://images/icon/item/Item_00001.png", false, "This is a class schedule", true, 6),
		item_infoData.new("res://images/icon/item/Item_00001.png", false, "This is a clock", true, 7),
		item_infoData.new("res://images/icon/item/Item_00001.png", false, "This is a desk", true, 8),
		item_infoData.new("res://images/icon/item/Item_00002.png", false, "This is a door", true, 9),
		item_infoData.new("res://images/icon/item/Item_00003.png", false, "This is a saying", true, 10),
		item_infoData.new("res://images/icon/item/Item_00004.png", false, "This is a schedule", true, 11),
		item_infoData.new("res://images/icon/item/Item_00005.png", false, "This is a ranking", true, 12),
	]
