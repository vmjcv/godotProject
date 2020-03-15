class_name SceneData
extends TextureRect

var number:int # 编号
var description:String
var down:int
var left:int
var right:int
var up:int


var item_panel

func _ready():
	pass


func _get_table():
	return configs.get_table_configs(configs.scene_changeData)

func _get_table_number(scene_number):
	var table = _get_table()
	for data in table:
		if data.number == scene_number:
			return data
	return null

func _load_table(load_dict):
	number = load_dict.number
	description = load_dict.description
	down = load_dict.down
	left = load_dict.left
	right = load_dict.right
	up = load_dict.up

func update_info(scene_number):
	var info = _get_table_number(scene_number)
	_load_table(info)
