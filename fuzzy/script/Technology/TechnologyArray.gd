class_name TechnologyArray

var technology_array:Dictionary # 数组
const TECHNLOGY_TYPE := "technolgy"
const NUMBER_TYPE := "number"
const RANK_TYPE := "rank"


func _init(array):
	technology_array = array
	
func append(technology):
	technology_array[TECHNLOGY_TYPE][technology.technlogy_type][NUMBER_TYPE][technology.number] = technology
	technology_array[TECHNLOGY_TYPE][technology.technlogy_type][RANK_TYPE][technology.rank].append(technology)
	technology_array[NUMBER_TYPE][technology.number] = technology
	
func remove(number:int):
	var technology = get_by_number(number)
	technology_array[TECHNLOGY_TYPE][technology.technlogy_type][NUMBER_TYPE].erase(technology.number)
	technology_array[TECHNLOGY_TYPE][technology.technlogy_type][RANK_TYPE][technology.rank].erase(technology)
	technology_array[NUMBER_TYPE].erase(number)
	
func get_by_type_rank(type,rank):
	# 获得某一类型某一阶位的全部科技
	return technology_array[TECHNLOGY_TYPE][type][RANK_TYPE][rank]
	
func get_by_number(number):
	# 通过编号得到得到科技
	return technology_array[NUMBER_TYPE][number]
	
func get_by_type(type) -> Dictionary:
	# 某一类型的全部科技列表
	return technology_array[TECHNLOGY_TYPE][type][NUMBER_TYPE]

func get_all() -> Dictionary:
	return technology_array[NUMBER_TYPE]

func size() -> int:
	return get_all().size()
