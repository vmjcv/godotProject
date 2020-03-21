extends Node

# 政策管理类，保存政策数据和政策树相关信息，非政策类调用政策内容只能通过manage进行调用

signal up

var all:PolicyTable # 所有政策
var finish:PolicyTable # 已完成政策
var propel:PolicyTable # 研发中政策
var selected_pool:PolicyTable # 可选政策池
var add_progress_number:float # 回合增加进度值
var remaining_progress:float # 剩余进度点
var now_select_policy:PolicyData # 当前选择政策
var slot_show_map:Dictionary # 槽位的状态信息

var policy_scene = preload("res://scene/Policy/Data.tscn")

func _init():
	_load_object(PlayerArchive.get_policy_manage())
	_init_normal_policy()
	# 测试代码，回合开始
	start_round()

func _update_slot_show_map():
	slot_show_map={}
	for number in finish.keys():
		var policy = finish.get(number)
		slot_show_map[number]=[policy.slot_show]
		
	for number in propel.keys():
		var policy = propel.get(number)
		slot_show_map[number]=[policy.slot_show]
	
	for number in selected_pool.keys():
		var policy = selected_pool.get(number)
		slot_show_map[number]=[policy.slot_show]
		
	return slot_show_map

func get(number):
	return all.get(number)

func recalculate_add_progress_number():
	add_progress_number = 10
	return add_progress_number

func add_progress(value):
	# 政策增加进度
	if remaining_progress > value:
		remaining_progress -= value
		value *= 2
	else:
		value = value + remaining_progress
		remaining_progress = 0

	var need_again = true
	var finish_flag = false
	while need_again:
		if propel.size() == 0:
			break
		need_again = false
		var finish_policy := [] #完成的科技
		var once_add = value / propel.size()
		for number in propel.keys():
			var result = propel.get(number).add_progress(once_add)
			value = value - once_add
			if result[0]:
				value = value + result[1]
				if result[1] > 0:
					need_again = true
				finish_policy.append(number)
				finish_flag = true
			else:
				pass
		for number in finish_policy:
			var policy = propel.get(number)
			finish.append(policy)
			propel.erase(policy)
	remaining_progress = remaining_progress + value
	return true

func start_round():
	recalculate_parameter()
	# 开始回合，计算研发点数开始研发
	add_progress(add_progress_number)
	_clear_now_select_policy()
	# 发射信号
	# emit_signal("start_round")

func recalculate_parameter():
	# 重算关键参数
	recalculate_add_progress_number()

func end_round():
	# 结束回合，锁定所有科技树上未开始的科技
	for number in propel.keys():
		propel.get(number).start = true
	
	_clear_now_select_policy()
	# 发射信号
	emit_signal("end_round")

func _clear_now_select_policy():
	now_select_policy = null
	_update_slot_show_map()


func save_object():
	var save_dict = {
		"all" : all.get_all().keys(),
		"finish" : finish.get_all().keys(),
		"propel" : propel.get_all().keys(),
		"selected_pool" : selected_pool.get_all().keys(),
		"add_progress_number" : add_progress_number,
		"remaining_progress" : remaining_progress,
	}
	return save_dict

func _load_object(load_dict):
	if load_dict == null:
		load_dict = {}
	var all_table = load_dict.get("all",Array(range(1,PolicyConstant.MAX_NUMBER+1)))
	all = PolicyTable.new(null)
	for number in all_table:
		var policy = policy_scene.instance()
		policy.update_info(number)
		all.append(policy)
		_registered_policy_signal(policy)
	var finish_table = load_dict.get("finish",all.get_by_tendency(PolicyConstant.Tendency.NORMAL))
	finish=PolicyTable.new(null)
	for number in finish_table:
		finish.append(all.get(number))
	var propel_table = load_dict.get("propel",[])
	propel=PolicyTable.new(null)
	for number in propel_table:
		propel.append(all.get(number))
	var selected_table = load_dict.get("selected_pool",[])
	selected_pool = PolicyTable.new(null)
	for number in selected_table:
		selected_pool.append(all.get(number))
	if selected_pool.empty():
		pass
	else:
		var radical_table = all.get_by_tendency(PolicyConstant.Tendency.RADICAL)
		var neutral_table = all.get_by_tendency(PolicyConstant.Tendency.NEUTRAL)
		var conservative_table = all.get_by_tendency(PolicyConstant.Tendency.CONSERVATIVE)
		for number in radical_table:
			selected_pool.append(all.get(number))
		for number in neutral_table:
			selected_pool.append(all.get(number))
		for number in conservative_table:
			selected_pool.append(all.get(number))
		
	add_progress_number = load_dict.get("add_progress_number",recalculate_add_progress_number())
	remaining_progress = load_dict.get("remaining_progress",0)

func _init_normal_policy():
	# 初始化当前已选政策
	for i in range(1,all.get_tree_count()+1):
		var policy_list = all.get_by_tree_id(i)
		var for_flag = true
		var normal_number
		for key in policy_list:
			if policy_list[key].tendency == PolicyConstant.Tendency.NORMAL:
				normal_number = policy_list[key].number
				policy_list[key].finish = true
			if policy_list[key].used:
				for_flag = false
				break
		if for_flag:
			policy_list[normal_number].used = true
			
func _registered_policy_signal(policy):
	policy.connect("up", self, "_up_policy_button")

func _up_policy_button(policy):
	now_select_policy = policy
	emit_signal("up",policy)
	pass
