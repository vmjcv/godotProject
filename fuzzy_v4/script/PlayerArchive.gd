# 玩家存档类
extends Node
var technology:Dictionary # 科技信息
var technology_manage # 科技管理器
var policy:Dictionary # 政策信息
var policy_manage # 政策管理器

func _init():
	technology = {}
	technology_manage = null
	policy = {}
	policy_manage = null

func save_technology(number):
	var save_game = File.new()
	save_game.open("user://savegame/technology%s.save"%number, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Tenchnology")
	for node in save_nodes:
		if node.filename.empty():
			continue

		if !node.has_method("save_object"):
			continue

		var node_data = node.call("save_object")
		save_game.store_line(to_json(node_data))
	save_game.close()

func save_technology_manage(number):
	var save_game = File.new()
	save_game.open("user://savegame/technology_manage%s.save"%number, File.WRITE)
	var node = get_tree().get_node("TechnologyManage")

	if node.filename.empty():
		save_game.close()
		return 

	if !node.has_method("save_object"):
		save_game.close()
		return 

	var node_data = node.call("save_object")
	save_game.store_line(to_json(node_data))
	save_game.close()

func save_policy(number):
	var save_game = File.new()
	save_game.open("user://savegame/policy%s.save"%number, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Policy")
	for node in save_nodes:
		if node.filename.empty():
			continue

		if !node.has_method("save_object"):
			continue

		var node_data = node.call("save_object")
		save_game.store_line(to_json(node_data))
	save_game.close()

func save_policy_manage(number):
	var save_game = File.new()
	save_game.open("user://savegame/policy_manage%s.save"%number, File.WRITE)
	var node = get_tree().get_node("PolicyManage")

	if node.filename.empty():
		save_game.close()
		return 

	if !node.has_method("save_object"):
		save_game.close()
		return 

	var node_data = node.call("save_object")
	save_game.store_line(to_json(node_data))
	save_game.close()

func save_game(number):
	save_technology(number)
	save_technology_manage(number)
	save_policy(number)
	save_policy_manage(number)
	
func load_technology(number):
	technology.clear()
	var save_game = File.new()
	if not save_game.file_exists("user://savegame/technology%s.save"%number):
		return 
	save_game.open("user://savegame/technology%s.save"%number, File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		technology[node_data.number]=node_data
	save_game.close()
	
func load_technology_manage(number):
	technology_manage = null
	var save_game = File.new()
	if not save_game.file_exists("user://savegame/technology_manage%s.save"%number):
		return 
	save_game.open("user://savegame/technology_manage%s.save"%number, File.READ)
	var node_data = parse_json(save_game.get_line())
	technology_manage = node_data
	save_game.close()
	
func load_policy(number):
	policy.clear()
	var save_game = File.new()
	if not save_game.file_exists("user://savegame/policy%s.save"%number):
		return 
	save_game.open("user://savegame/policy%s.save"%number, File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		policy[node_data.number]=node_data
	save_game.close()
	
func load_policy_manage(number):
	policy_manage = null
	var save_game = File.new()
	if not save_game.file_exists("user://savegame/policy_manage%s.save"%number):
		return 
	save_game.open("user://savegame/policy_manage%s.save"%number, File.READ)
	var node_data = parse_json(save_game.get_line())
	policy_manage = node_data
	save_game.close()

func load_game(number):
	load_technology(number)
	load_technology_manage(number)
	load_policy(number)
	load_policy_manage(number)
	
func get_technology(technology_number):
	return technology.get(technology_number)
	
func get_technology_manage():
	return technology_manage
	
func get_policy(policy_number):
	return policy.get(policy_number)
	
func get_policy_manage():
	return policy_manage
