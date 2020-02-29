class_name TechnologyTable

extends Node

# 科技存储集合结构类

enum warehouse_key {
	CATEGORY, # 有分类的仓库
	NUMBER, # 数字做索引的仓库
	RANK # 阶位做索引的仓库
}

var _warehouse:Dictionary # 数组

func _init(other_warehouse):
	if other_warehouse:
		_warehouse = other_warehouse
	else:
		_warehouse = _create_warehouse()
	
func append(obj) -> bool:
	# 如果有树上的类型那么就按树上的类型添加
	if obj.in_tree:
		_warehouse[warehouse_key.CATEGORY][obj.tree_category][warehouse_key.NUMBER][obj.number] = obj
		if _warehouse[warehouse_key.CATEGORY][obj.tree_category][warehouse_key.RANK].get(obj.tree_rank):
			pass
		else:
			_warehouse[warehouse_key.CATEGORY][obj.tree_category][warehouse_key.RANK][obj.tree_rank]={}
		_warehouse[warehouse_key.CATEGORY][obj.tree_category][warehouse_key.RANK][obj.tree_rank][obj.number]=obj
	else:
		for category in obj.category:
			category = int(category)
			_warehouse[warehouse_key.CATEGORY][category][warehouse_key.NUMBER][obj.number] = obj
			if _warehouse[warehouse_key.CATEGORY][category][warehouse_key.RANK].get(obj.rank):
				pass
			else:
				_warehouse[warehouse_key.CATEGORY][category][warehouse_key.RANK][obj.rank]={}
			_warehouse[warehouse_key.CATEGORY][category][warehouse_key.RANK][obj.rank][obj.number]=obj
	_warehouse[warehouse_key.NUMBER][obj.number] = obj
	return true
	
func erase(obj) -> bool:
	var rela_obj = get(obj)
	if rela_obj:
		if rela_obj.in_tree:
			_warehouse[warehouse_key.CATEGORY][rela_obj.tree_category][warehouse_key.NUMBER].erase(rela_obj.number)
			_warehouse[warehouse_key.CATEGORY][rela_obj.tree_category][warehouse_key.RANK][rela_obj.tree_rank].erase(rela_obj.number)
			_warehouse[warehouse_key.NUMBER].erase(rela_obj.number)
			return true
		else:
			for category in rela_obj.category:
				category = int(category)
				_warehouse[warehouse_key.CATEGORY][category][warehouse_key.NUMBER].erase(rela_obj.number)
				_warehouse[warehouse_key.CATEGORY][category][warehouse_key.RANK][rela_obj.rank].erase(rela_obj.number)
			_warehouse[warehouse_key.NUMBER].erase(rela_obj.number)
			return true
	else:
		return false
	
func empty() -> bool:
	return size()!=0

func clear() -> void:
	_warehouse = _create_warehouse()

func update(other_table:TechnologyTable):
	# 合并另外的数组
	for number in other_table.all():
		append(other_table.get(number))
		
func size() -> int:
	return values().size()
	
func values() -> Array:
	# 全部科技列表
	return _warehouse[warehouse_key.NUMBER].values()

func keys() -> Array:
	return _warehouse[warehouse_key.NUMBER].keys()
	
func all() -> Dictionary:
	return _warehouse[warehouse_key.NUMBER]
	
func get(obj):
	if obj is int:
		return all().get(obj)
	elif obj is TechnologyData:
		return all().get(obj.number)
	
func has(obj):
	var rela_obj = get(obj)		
	if rela_obj:
		return true
	else:
		return false

func get_by_category(category) -> Dictionary:
	# 某一类型的全部科技列表
	return _warehouse[warehouse_key.CATEGORY][category][warehouse_key.NUMBER]

func get_by_category_rank(category,rank) -> Dictionary:
	# 某一类型某一阶位的全部科技
	return _warehouse[warehouse_key.CATEGORY][category][warehouse_key.RANK].get(rank,{})

func get_random_technology(amount, category = -1, random_warehouse = null) -> TechnologyTable:
	# 根据权重值随机获得部分科技
	if random_warehouse:
		pass
	else:
		var warehouse_class = get_script()
		random_warehouse = warehouse_class.new(null)
		
	var random_pool
	if category == -1:
		random_pool = all()
	else:
		random_pool = get_by_category(category)

	for _i in range(amount):
		var total_weights = 0
		for number in random_pool:
			if not random_warehouse.has(number):
				var add_weights = get(number).weights
				total_weights = total_weights + add_weights
		var want_weights = rand_range(0,total_weights)
		total_weights = 0
		for number in random_pool:
			if not random_warehouse.has(number):
				var add_weights = get(number).weights
				total_weights = total_weights + add_weights
				if total_weights >= want_weights:
					# 取这个科技
					random_warehouse.append(get(number))
					break
	return random_warehouse

func _create_warehouse() -> Dictionary: 
	var warehouse={
				warehouse_key.CATEGORY:{
					TechnologyConstant.Category.DESCENT:{
						warehouse_key.NUMBER:{},
						warehouse_key.RANK:{
						},
					},
					TechnologyConstant.Category.MAGIC:{
						warehouse_key.NUMBER:{},
						warehouse_key.RANK:{
						},
					},
					TechnologyConstant.Category.SCIENCE:{
						warehouse_key.NUMBER:{},
						warehouse_key.RANK:{
						},
					}
				},
				warehouse_key.NUMBER:{
				}
			}
	return warehouse
