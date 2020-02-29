# Tool generated file DO NOT MODIFY
tool
extends Node

const technology_infoScript = preload("technology_info.gd")
const policy_infoScript = preload("policy_info.gd")
const technology_infoData = technology_infoScript.technology_infoData
const policy_infoData = policy_infoScript.policy_infoData

var unique_id_depot = {}
var configs = {
	technology_infoData: [],
	policy_infoData: [],
}

func get_config_by_uid(id: int):
	return unique_id_depot[id] if id in unique_id_depot else null

func get_table_configs(table: GDScript):
	return configs[table] if table in configs else null

func _init():
	configs[technology_infoData] = technology_infoScript.load_configs()
	configs[policy_infoData] = policy_infoScript.load_configs()
	for d in configs[technology_infoData]: unique_id_depot[d.get_instance_id()] = d
	for d in configs[policy_infoData]: unique_id_depot[d.get_instance_id()] = d
