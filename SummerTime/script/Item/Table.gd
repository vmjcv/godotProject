class_name ItemTable

extends Node

# 存储集合结构类

enum warehouse_key {
	NUMBER, # 数字做索引的仓库
}

var _warehouse:Dictionary # 数组

func _init(other_warehouse):
	if other_warehouse:
		_warehouse = other_warehouse
	else:
		_warehouse = _create_warehouse()
	
func append(obj) -> bool:
	_warehouse[warehouse_key.NUMBER][obj.number] = obj
	return true
	
func erase(obj) -> bool:
	var rela_obj = get(obj)
	if rela_obj:
		_warehouse[warehouse_key.NUMBER].erase(rela_obj.number)
		return true
	else:
		return false
	
func empty() -> bool:
	return size()!=0

func clear() -> void:
	_warehouse = _create_warehouse()

func update(other_table:ItemTable):
	# 合并另外的数组
	for number in other_table.all():
		append(other_table.get(number))
		
func size() -> int:
	return values().size()
	
func values() -> Array:
	# 全部道具列表
	return _warehouse[warehouse_key.NUMBER].values()

func keys() -> Array:
	return _warehouse[warehouse_key.NUMBER].keys()
	
func all() -> Dictionary:
	return _warehouse[warehouse_key.NUMBER]
	
func get(obj):
	if obj is int:
		return all().get(obj)
	elif obj is ItemData:
		return all().get(obj.number)
	
func has(obj):
	var rela_obj = get(obj)		
	if rela_obj:
		return true
	else:
		return false

func _create_warehouse() -> Dictionary: 
	var warehouse={
				warehouse_key.NUMBER:{
				}
			}
	return warehouse
