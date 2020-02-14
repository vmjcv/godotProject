extends Node
class_name TechnologyArray

var technology_array:Dictionary # 数组
const TECHNLOGY_TYPE := "technolgy"
const NUMBER_TYPE := "number"
const RANK_TYPE := "rank"

func _init(array):
	if not array:
		array={
			TECHNLOGY_TYPE:{
				Global.TechnologyType.DESCENT:{
					NUMBER_TYPE:{},
					RANK_TYPE:{
					},
				},
				Global.TechnologyType.MAGIC:{
					NUMBER_TYPE:{},
					RANK_TYPE:{
					},
				},
				Global.TechnologyType.SCIENCE:{
					NUMBER_TYPE:{},
					RANK_TYPE:{
					},
				}
			},
			NUMBER_TYPE:{
			}
		}
		for i in range(1,Global.RANK_MAX_NUMBER+1):
			array[TECHNLOGY_TYPE][Global.TechnologyType.DESCENT][RANK_TYPE][i]=[]
			array[TECHNLOGY_TYPE][Global.TechnologyType.MAGIC][RANK_TYPE][i]=[]
			array[TECHNLOGY_TYPE][Global.TechnologyType.SCIENCE][RANK_TYPE][i]=[]
			
	technology_array = array

func append(technology):
	for one_technlogy_type in technology.technlogy_type:
		one_technlogy_type = int(one_technlogy_type)
		technology_array[TECHNLOGY_TYPE][one_technlogy_type][NUMBER_TYPE][technology.number] = technology
		technology_array[TECHNLOGY_TYPE][one_technlogy_type][RANK_TYPE][technology.rank].append(technology)
	technology_array[NUMBER_TYPE][technology.number] = technology
	

func remove(number:int):
	var technology = get_by_number(number)
	for one_technlogy_type in technology.technlogy_type:
		one_technlogy_type = int(one_technlogy_type)
		technology_array[TECHNLOGY_TYPE][one_technlogy_type][NUMBER_TYPE].erase(technology.number)
		technology_array[TECHNLOGY_TYPE][one_technlogy_type][RANK_TYPE][technology.rank].erase(technology)
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

func get_random_technology(amount,technology_type = -1,random_technology = null):
	# 根据权重值随机获得部分科技
	if random_technology:
		pass
	else:
		var TechnologyArrayClass = get_script()
		random_technology = TechnologyArrayClass.new(null)
	var all_technology
	if technology_type == -1:
		all_technology = get_all()
	else:
		all_technology = get_by_type(technology_type)

	for _i in range(amount):
		var total_weights = 0
		for number in all_technology:
			if not random_technology.have_number(number):
				var add_weights = get_by_number(number).get_weights()
				total_weights = total_weights + add_weights
		var want_weights = rand_range(0,total_weights)
		total_weights = 0
		for number in all_technology:
			if not random_technology.have_number(number):
				var add_weights = get_by_number(number).get_weights()
				total_weights = total_weights + add_weights
				if total_weights >= want_weights:
					# 取这个科技
					random_technology.append(get_by_number(number))
					break
	return random_technology

func have_number(number):
	return technology_array[NUMBER_TYPE].get(number)!=null

func update(other_technology:TechnologyArray):
	# 合并另外的数组
	for number in other_technology.get_all():
		append(other_technology.get_by_number(number))
	
