extends Node

# 科技管理类，保存科技数据和科技树相关信息，非科技类调用科技内容只能通过manage进行调用

signal selected_pool_to_propel
signal propel_to_propel
signal propel_to_selected_pool
signal selected_pool_update
signal down
signal up
signal start_round
signal end_round

var all:TechnologyTable # 所有科技
var finish:TechnologyTable # 已完成科技
var propel:TechnologyTable # 研发中科技
var selected_pool:TechnologyTable # 可选科技池
var selected_number:Dictionary # 随机可选科技数量，[3,4,3]
var selected_rank_number:Dictionary # 可选科技的阶位数量
var add_progress_number:float # 回合增加进度值
var round_start_number:int # 当前回合可以开始的科技数量
var remaining_progress:float # 剩余进度点
var now_select_technology:TechnologyData # 当前选择科技
var slot_show_map:Dictionary # 槽位的状态信息

var technology_scene = preload("res://scene/Technology/Data.tscn")

func _init():
	_load_object(PlayerArchive.get_technology_manage())
	
	# 测试代码，回合开始
	start_round()
	_update_selected_pool()
	pass

func to_propel(technology,slot):
	if technology.in_tree:
		check_propel_to_propel(technology,slot)
	else:
		check_selected_pool_to_propel(technology,slot)

func to_selected_pool(technology):
	if technology.in_tree:
		check_propel_to_selected_pool(technology)
	else:
		pass
		
func check_selected_pool_to_propel(technology,slot):
	# 检测科技是否可以从待选池移到科技的某个格子上
	if technology.check_add_selected()[0]:
		if slot.get_child_count()==0:
			if _check_equal(technology,slot):
				if _have_round_start_number():
					_selected_pool_to_propel(technology,slot.category,slot.rank,slot.id)
	pass

func _have_round_start_number():
	# 判断是否有研究空位
	var total = round_start_number
	for number in propel.all():
		if propel.get(number).finish==false:
			total = total -1
	return total>0

func _selected_pool_to_propel(technology,category,rank,id):
	# 将科技从待选池移到科技树上的某个格子
	technology.in_tree = true
	technology.in_selected = false
	technology.tree_category = category
	technology.tree_rank = rank
	technology.tree_rank_id = id
	propel.append(technology)
	selected_pool.erase(technology)
	_update_slot_show_map()
	_clear_now_select_technology()
	emit_signal("selected_pool_to_propel",technology) # 发送科技更新信号去更新ui
	pass

func check_propel_to_propel(technology,slot):
	# 检测科技是否可以从一个科技树格子移动到另外一个科技树格子，只有科技还没开始正式研发的时候才可切换
	if technology.check_add_selected()[0]:
		if slot.get_child_count()==0:
			if _check_equal(technology,slot):
				_propel_to_propel(technology,slot.category,slot.rank,slot.id)

func _check_equal(technology,slot):
	if technology.rank == slot.rank:
		if slot.category in technology.category:
			return true
	return false
	
func _propel_to_propel(technology,category,rank,id):
	# 将科技从待选池移到科技树上的某个格子
	technology.tree_category = category
	technology.tree_rank = rank
	technology.tree_rank_id = id
	_update_slot_show_map()
	_clear_now_select_technology()
	emit_signal("propel_to_propel",technology) # 发送科技更新信号去更新ui
	pass

func check_propel_to_selected_pool(technology):
	# 检测科技是否可以从一个科技树格子移动到待选池，只有科技还没开始正式研发的时候才可切换
	if technology.check_add_selected()[0]:
		_propel_to_selected_pool(technology)
	pass
	
func _propel_to_selected_pool(technology):
	# 将科技从科技树格子移动到待选池
	technology.in_tree = false
	technology.in_selected = true
	technology.tree_category = 0
	technology.tree_rank = 0
	technology.tree_rank_id = 0
	selected_pool.append(technology)
	propel.erase(technology)
	_update_slot_show_map()
	_clear_now_select_technology()
	emit_signal("propel_to_selected_pool",technology) # 发送科技更新信号去更新ui
	pass

func _update_slot_show_map():
	slot_show_map={}
	for number in finish.keys():
		var technology = finish.get(number)
		slot_show_map[number]=[technology.slot_show]
		
	for number in propel.keys():
		var technology = propel.get(number)
		slot_show_map[number]=[technology.slot_show]
	
	for number in selected_pool.keys():
		var technology = selected_pool.get(number)
		slot_show_map[number]=[technology.slot_show]
	
	if now_select_technology:
		var need_technologies = now_select_technology.precondition
		var need_finish = true
		var i = 1
		for need_technology_list in need_technologies:
			need_finish = true
			for need_technology in need_technology_list:
				if not finish.get(int(need_technology)).finish:
					need_finish = false
					break
			if need_finish:
				# 这个前提数组可以使用
				for need_technology in need_technology_list:
					slot_show_map[int(need_technology)]=[TechnologyConstant.SlotShow.PRECONDITION,i]
	return slot_show_map


func get(number):
	return all.get(number)
	
func recalculate_selected_number():
	# 通过政策重算数据
	selected_number = {TechnologyConstant.Category.DESCENT:3,TechnologyConstant.Category.SCIENCE:4,TechnologyConstant.Category.MAGIC:3}
	return selected_number
	
func recalculate_selected_rank_number():
	# 通过政策重算数据
	selected_rank_number = {
		TechnologyConstant.Category.DESCENT:{
			7:1,
			6:2,
			5:2,
			4:3,
			3:3,
			2:4,
			1:4
		},
		TechnologyConstant.Category.SCIENCE:{
			7:1,
			6:2,
			5:2,
			4:3,
			3:3,
			2:4,
			1:4
		},
		TechnologyConstant.Category.MAGIC:{
			7:1,
			6:2,
			5:2,
			4:3,
			3:3,
			2:4,
			1:4
		}
	}
	return selected_rank_number

func recalculate_add_progress_number():
	add_progress_number = 10
	return add_progress_number

func recalculate_round_start_number():
	round_start_number = 1
	return round_start_number
	
func add_progress(value):
	# 科技增加进度
	value = remaining_progress + value

	var need_again = true
	var finish_flag = false
	while need_again:
		if propel.size() == 0:
			break
		need_again = false
		var finish_technology := [] #完成的科技
		var once_add = value / propel.size()
		for number in propel.keys():
			var result = propel.get(number).add_progress(once_add)
			value = value - once_add
			if result[0]:
				value = value + result[1]
				if result[1] > 0:
					need_again = true
				finish_technology.append(number)
				finish_flag = true
			else:
				pass
		for number in finish_technology:
			var technology = propel.get(number)
			finish.append(technology)
			propel.erase(technology)
	if finish_flag:
		_update_selected_pool()
	return true

func start_round():
	recalculate_parameter()
	# 开始回合，计算研发点数开始研发
	add_progress(add_progress_number)
	_clear_now_select_technology()
	# 发射信号
	emit_signal("start_round")

func recalculate_parameter():
	# 重算关键参数
	recalculate_selected_rank_number()
	recalculate_selected_number()
	recalculate_add_progress_number()
	recalculate_round_start_number()

func end_round():
	# 结束回合，锁定所有科技树上未开始的科技
	for number in propel.keys():
		propel.get(number).start = true
	
	_clear_now_select_technology()
	# 发射信号
	emit_signal("end_round")

func _clear_now_select_technology():
	now_select_technology = null
	_update_slot_show_map()

func _update_selected_pool():
	# 更新待选区科技
	# 将当前可选科技池中的科技增加已出现次数
	for number in selected_pool.keys():
		selected_pool.get(number).add_appear_number()
	# 得到所有当前可出现的科技
	var selected_technology = TechnologyTable.new(null)
	
	for number in all.keys():
		var technology = all.get(number)
		var result = _check_add_selected(technology)
		if result[0] == false:
			# 无法选择此科技
			pass
		else:
			if result[1]==TechnologyConstant.AddSelected.CANSELECTED:
				# 待选科技
				selected_technology.append(technology)
	# 在所有待选科技中选择几个科技
	var random_technology = {}
	selected_pool = TechnologyTable.new(null)
	
	for category in selected_number:
		var need_size = selected_number[category]
		var random_category = TechnologyTable.new(null)
		var want_size = selected_pool.size()+selected_number[category]
		while need_size!=0:
			selected_technology.get_random_technology(need_size,category,random_category)
			random_technology[category] = random_category
			selected_pool.update(random_technology[category])
			var end_size = selected_pool.size()
			need_size = want_size - end_size
	emit_signal("selected_pool_update")
	
func _check_add_selected(technology) -> Array:
	# 检查某个科技是否可选
	var can_add_selected:Array = technology.check_add_selected()
	if can_add_selected[0] == false:
		# 已开始者已完成说明不可加入待选科技
		return can_add_selected
	# 检查某个科技是否符合前置条件
	var need_technologies = technology.precondition
	var need_finish = true
	for need_technology_list in need_technologies:
		need_finish = true
		for number in need_technology_list:
			if not get(int(number)).finish:
				need_finish = false
				break
		if need_finish:
			break
	if not need_finish:
		# 前置条件无法满足
		return [false,TechnologyConstant.AddSelected.DISPRECONDITION]
	var rank = technology.rank
	var category = technology.category
	# 科技类别为Array
	for one_category in category:
		one_category = int(one_category)
		var finish_number = finish.get_by_category_rank(one_category,rank).size()
		var propel_number = propel.get_by_category_rank(one_category,rank).size()
		var max_number = selected_rank_number[one_category][rank]

		if max_number <= finish_number + propel_number:
			pass
		else:
			# 可处于待选状态
			return [true,TechnologyConstant.AddSelected.CANSELECTED]
	# 阶位已满
	return [false,TechnologyConstant.AddSelected.RANK_FULL]

func save_object():
	var save_dict = {
		"all" : all.get_all().keys(),
		"finish" : finish.get_all().keys(),
		"propel" : propel.get_all().keys(),
		"selected_pool" : selected_pool.get_all().keys(),
		"selected_number" : selected_number,
		"selected_rank_number" : selected_rank_number,
		"add_progress_number" : add_progress_number,
		"round_start_number" : round_start_number,
		"remaining_progress" : remaining_progress,
	}
	return save_dict

func _load_object(load_dict):
	if load_dict == null:
		load_dict = {}
	var all_table = load_dict.get("all",Array(range(1,TechnologyConstant.MAX_NUMBER+1)))
	all=TechnologyTable.new(null)
	for number in all_table:
		var technology = technology_scene.instance()
		technology.update_info(number)
		all.append(technology)
		_registered_technology_signal(technology)
	var finish_table = load_dict.get("finish",[])
	finish=TechnologyTable.new(null)
	for number in finish_table:
		finish.append(all.get(number))
	var propel_table = load_dict.get("propel",[])
	propel=TechnologyTable.new(null)
	for number in propel_table:
		propel.append(all.get(number))
	var selected_table = load_dict.get("selected_pool",[])
	selected_pool = TechnologyTable.new(null)
	for number in selected_table:
		selected_pool.append(all.get(number))
	selected_number = load_dict.get("selected_number", recalculate_selected_number())
	selected_rank_number = load_dict.get("selected_rank_number",recalculate_selected_rank_number())
	add_progress_number = load_dict.get("add_progress_number",recalculate_add_progress_number())
	round_start_number = load_dict.get("round_start_number",recalculate_round_start_number())
	remaining_progress = load_dict.get("remaining_progress",0)

func _registered_technology_signal(technology):
	technology.connect("down", self, "_down_technology_button")
	technology.connect("up", self, "_up_technology_button")

func _down_technology_button(technology):
	now_select_technology = technology
	_update_slot_show_map()
	
	emit_signal("down",technology)
	pass
	
func _up_technology_button(technology):
	emit_signal("up",technology)
	pass
