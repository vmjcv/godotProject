extends Node

# 政策管理类，保存政策数据和政策树相关信息，非政策类调用政策内容只能通过manage进行调用

signal up
signal begin_policy
signal use_policy
signal start_round
signal end_round
signal clear_now_select

var all:PolicyTable # 所有政策，大于可选政策池，随着游戏进程的进程或其他原因，逐步增加当前可选政策池
var selected_pool:PolicyTable # 当前可选政策池
var finish:PolicyTable # 已完成政策
var propel:PolicyTable # 研发中政策
var now_used:PolicyTable # 当前使用中的政策
var add_progress_number:float # 每回合增加进度值
var round_start_number:int # 当前回合可以开始的政策数量
var remaining_progress:float # 剩余进度点池
var now_select_policy:PolicyData # 当前选择政策
var slot_show_map:Dictionary # 槽位的状态信息

var policy_scene = preload("res://scene/Policy/Data.tscn")

func _init():
	_load_object(PlayerArchive.get_policy_manage())
	_init_initial_policy()
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
	add_progress_number = 1
	return add_progress_number


func recalculate_round_start_number():
	round_start_number = 1
	return round_start_number

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
	emit_signal("start_round")

func recalculate_parameter():
	# 重算关键参数
	recalculate_add_progress_number()
	recalculate_round_start_number()

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
	emit_signal("clear_now_select")

func save_object():
	var save_dict = {
		"all" : all.get_all().keys(),
		"finish" : finish.get_all().keys(),
		"propel" : propel.get_all().keys(),
		"selected_pool" : selected_pool.get_all().keys(),
		"add_progress_number" : add_progress_number,
		"remaining_progress" : remaining_progress,
		"now_used" : now_used.get_all().keys(),
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
	var finish_table = load_dict.get("finish",all.get_by_tendency(PolicyConstant.Tendency.TAOISM))
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
		var taoism_table = all.get_by_tendency(PolicyConstant.Tendency.TAOISM)
		var mohist_table = all.get_by_tendency(PolicyConstant.Tendency.MOHIST)
		var confucianism_table = all.get_by_tendency(PolicyConstant.Tendency.CONFUCIANISM)
		var legalist_table = all.get_by_tendency(PolicyConstant.Tendency.LEGALIST)
		
		for number in taoism_table:
			selected_pool.append(all.get(number))
		for number in mohist_table:
			selected_pool.append(all.get(number))
		for number in confucianism_table:
			selected_pool.append(all.get(number))
		for number in legalist_table:
			selected_pool.append(all.get(number))
	
	var now_used_table = load_dict.get("now_used",[])
	now_used=PolicyTable.new(null)
	for number in now_used_table:
		var policy = all.get(number)
		policy.finish = true
		policy.used = true
		now_used.append(policy)
	
	add_progress_number = load_dict.get("add_progress_number",recalculate_add_progress_number())
	remaining_progress = load_dict.get("remaining_progress",0)

func _init_initial_policy():
	# 初始化当前已选政策
	for i in range(1,all.tree_count+1):
		var policy_list = all.get_by_tree_id(i)
		var for_flag = true
		var taoism_number
		for key in policy_list:
			if policy_list[key].tendency == PolicyConstant.Tendency.TAOISM or i==5:
				taoism_number = policy_list[key].number
				policy_list[key].finish = true
				policy_list[key].now_RD_progress = policy_list[key].all_progress
				finish.append(policy_list[key])
				
			if policy_list[key].used:
				for_flag = false
				now_used.append(policy_list[key])
				break
		if for_flag:
			if i == 5:
				taoism_number = finish.get_by_tendency_tree_id(PolicyConstant.Tendency.TAOISM,5).number
			policy_list[taoism_number].used = true
			now_used.append(policy_list[taoism_number])
			
func _registered_policy_signal(policy):
	policy.connect("up", self, "_up_policy_button")

func _up_policy_button(policy):
	now_select_policy = get(policy)
	emit_signal("up",policy)
	pass

func _have_round_start_number():
	# 判断是否有研究空位
	var total = round_start_number
	for number in propel.all():
		if propel.get(number).finish==false:
			total = total -1
	return total>0

func begin_policy(now_select_policy):
	# 将政策从待选池移到政策树上的某个格子
	now_select_policy.start = true
	propel.append(now_select_policy)
	selected_pool.erase(now_select_policy)
	_update_slot_show_map()
	emit_signal("begin_policy",now_select_policy) # 发送政策更新信号去更新ui
	pass

func begin_one_policy():
	if _have_round_start_number() and get(now_select_policy):
		begin_policy(get(now_select_policy))
	pass

func _can_change_policy():
	return true

func use_one_policy():
	if _can_change_policy():
		use_policy(get(now_select_policy))
	pass
	
func use_policy(now_select_policy):
	for number in now_used.get_by_tree_id(now_select_policy.tree_id):
		get(number).used = false
		now_used.erase(number)
	now_used.append(now_select_policy)
	now_select_policy.used=true
	
	var taoism_number= now_used.get_by_tendency(PolicyConstant.Tendency.TAOISM).size()
	var mohist_number= now_used.get_by_tendency(PolicyConstant.Tendency.MOHIST).size()
	var confucianism_number= now_used.get_by_tendency(PolicyConstant.Tendency.CONFUCIANISM).size()
	var legalist_number= now_used.get_by_tendency(PolicyConstant.Tendency.LEGALIST).size()
	var center = get(now_used.get_by_tree_id(5))
	var center_tendency = center[0].tendency if center else -1
	if center_tendency==PolicyConstant.Tendency.TAOISM:
		taoism_number = taoism_number-1
		pass
	elif center_tendency==PolicyConstant.Tendency.MOHIST:
		mohist_number = mohist_number-1
		pass
	elif center_tendency==PolicyConstant.Tendency.CONFUCIANISM:
		confucianism_number = confucianism_number-1
		pass
	elif center_tendency==PolicyConstant.Tendency.LEGALIST:
		legalist_number = legalist_number-1
		pass
	
	var result_tendency =-1
	
	if taoism_number>=5:
		result_tendency = PolicyConstant.Tendency.TAOISM
		pass
	elif mohist_number>=5:
		result_tendency = PolicyConstant.Tendency.MOHIST
		pass
	elif confucianism_number>=5:
		result_tendency = PolicyConstant.Tendency.CONFUCIANISM
		pass
	elif legalist_number>=5:
		result_tendency = PolicyConstant.Tendency.LEGALIST
		pass
		
	if result_tendency == center_tendency:
		pass
	else:
		var number = now_used.get_by_tree_id(5).keys()
		number = number[0] if number else -1
		if number>=0:
			get(number).used=false
			now_used.erase(get(number))
		var temp_policy = finish.get_by_tendency_tree_id(result_tendency,5)
		temp_policy.used=true
		now_used.append(temp_policy)
		
	_update_slot_show_map()
	emit_signal("use_policy",now_select_policy) # 发送政策更新信号去更新ui
	pass
