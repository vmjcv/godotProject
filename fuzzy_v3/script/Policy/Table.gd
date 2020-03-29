class_name PolicyTable

extends Node

# 政策存储集合结构类

enum warehouse_key {
	TENDENCY, # 有倾向的仓库
	NUMBER, # 数字做索引的仓库
	TREE # 树编号做索引的仓库
}

var _warehouse:Dictionary # 数组
var tree_count setget ,get_tree_count

func _init(other_warehouse):
	if other_warehouse:
		_warehouse = other_warehouse
	else:
		_warehouse = _create_warehouse()
	
func append(obj) -> bool:
	_warehouse[warehouse_key.TENDENCY][obj.tendency][warehouse_key.NUMBER][obj.number] = obj
	_warehouse[warehouse_key.TENDENCY][obj.tendency][warehouse_key.TREE][obj.tree_id] = obj

	_warehouse[warehouse_key.NUMBER][obj.number] = obj
	
	if _warehouse[warehouse_key.TREE].get(obj.tree_id):
		pass
	else:
		_warehouse[warehouse_key.TREE][obj.tree_id] = {}
	_warehouse[warehouse_key.TREE][obj.tree_id][obj.number] = obj
	return true
	
func erase(obj) -> bool:
	var rela_obj = get(obj)
	if rela_obj:
		_warehouse[warehouse_key.TENDENCY][rela_obj.tendency][warehouse_key.NUMBER].erase(rela_obj.number)
		_warehouse[warehouse_key.TENDENCY][rela_obj.tendency][warehouse_key.TREE].erase(rela_obj.tree_id)
		_warehouse[warehouse_key.NUMBER].erase(rela_obj.number)
		_warehouse[warehouse_key.TREE][rela_obj.tree_id].erase(rela_obj.number)
		return true
	else:
		return false
	
func empty() -> bool:
	return size()!=0

func clear() -> void:
	_warehouse = _create_warehouse()

func update(other_table:PolicyTable):
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
	elif obj is PolicyData:
		return all().get(obj.number)
	
func has(obj):
	var rela_obj = get(obj)		
	if rela_obj:
		return true
	else:
		return false

func get_by_tendency(tendency) -> Dictionary:
	# 某一倾向的全部政策列表
	return _warehouse[warehouse_key.TENDENCY][tendency][warehouse_key.NUMBER]

func get_by_tendency_tree_id(tendency,tree_id):
	# 某一倾向某一位置的政策
	return _warehouse[warehouse_key.TENDENCY][tendency][warehouse_key.TREE].get(tree_id,null)
	
func get_by_tree_id(tree_id):
	# 某一位置的政策
	return _warehouse[warehouse_key.TREE].get(tree_id,{})

func get_tree_count():
	return _warehouse[warehouse_key.TREE].size()	

func _create_warehouse() -> Dictionary: 
	var warehouse={
				warehouse_key.TENDENCY:{
					PolicyConstant.Tendency.TAOISM:{
						warehouse_key.NUMBER:{},
						warehouse_key.TREE:{
						},
					},
					PolicyConstant.Tendency.MOHIST:{
						warehouse_key.NUMBER:{},
						warehouse_key.TREE:{
						},
					},
					PolicyConstant.Tendency.CONFUCIANISM:{
						warehouse_key.NUMBER:{},
						warehouse_key.TREE:{
						},
					},
					PolicyConstant.Tendency.LEGALIST:{
						warehouse_key.NUMBER:{},
						warehouse_key.TREE:{
						},
					},
				},
				warehouse_key.NUMBER:{
				},
				warehouse_key.TREE:{
				}
			}
	return warehouse
