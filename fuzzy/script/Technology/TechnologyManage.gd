extends Node
const technology_scene = preload("res://Technology.tscn")
signal technology_click_update
# 科技管理器，每次研发完成可以重新更新可研发科技
var all_technology:TechnologyArray # 所有科技
var now_technology:TechnologyArray # 当前已研发完成科技
var process_technology:TechnologyArray # 当前正在研发科技
var optional_technology:TechnologyArray # 当前可选科技
var optional_number:Dictionary # 可选科技数量，[3,4,3]
var optional_rank_number:Dictionary # 可选科技的阶位数量 Global.TechnologyType.DESCENT:[1:4,2:4,3:3,4:3,5:2,6:2,7:1]
var remaining_progress:float # 剩余进度点

var now_click_technology:Technology setget set_now_click_technology,get_now_click_technology# 当前点击科技
var bg_type_map:Dictionary # 显示点击科技导致科技树上的点背景的显示

func _init():
	load_object(PlayerArchive.get_technology_manage())
	pass

func set_now_click_technology(technology):
	print("2222222222")
	now_click_technology = technology
	update_bg_type_map()
	emit_signal("technology_click_update")
	
func get_now_click_technology():
	return now_click_technology

func update_bg_type_map():
	bg_type_map={}
	for technlogy_number in now_technology.get_all():
		var technology = now_technology.get_by_number(technlogy_number)
		bg_type_map[technlogy_number]=[technology.display_info]
		
	for technlogy_number in process_technology.get_all():
		var technology = process_technology.get_by_number(technlogy_number)
		bg_type_map[technlogy_number]=[technology.display_info]
	
	var need_technologies = now_click_technology.precondition
	var need_finish = true
	var i=1
	for need_technology_list in need_technologies:
		need_finish = true
		for need_technology in need_technology_list:
			if not now_technology.get_by_number(need_technology).get_finish():
				need_finish = false
				break
		if need_finish:
			# 这个前提数组可以使用
			for need_technology in need_technology_list:
				bg_type_map[need_technology]=[Global.TechnologyBGType.PRECONDITION,i]
	return bg_type_map

func get_technology(technlogy_number):
	return all_technology.get_by_number(technlogy_number)
	
func recalculate_optional_number():
	# 通过政策重算数据
	optional_number = {Global.TechnologyType.DESCENT:3,Global.TechnologyType.SCIENCE:4,Global.TechnologyType.MAGIC:3}
	return optional_number
	
func recalculate_optional_rank_number():
	# 通过政策重算数据
	optional_rank_number = {
		Global.TechnologyType.DESCENT:{
			7:1,
			6:2,
			5:2,
			4:3,
			3:3,
			2:4,
			1:4
		},
		Global.TechnologyType.SCIENCE:{
			7:1,
			6:2,
			5:2,
			4:3,
			3:3,
			2:4,
			1:4
		},
		Global.TechnologyType.MAGIC:{
			7:1,
			6:2,
			5:2,
			4:3,
			3:3,
			2:4,
			1:4
		}
	}
	return optional_rank_number
	
func add_progress(value):
	# 科技增加进度
	value = remaining_progress + value
	var need_again = true
	var finish = false
	while need_again:
		need_again = false
		var finish_technology := [] #完成的科技
		var once_add = value / process_technology.size()
		var all_process_technology = process_technology.get_all()
		for technology_number in all_process_technology:
			var result = process_technology.get_by_number(technology_number).add_progress(once_add)
			value = value - once_add
			if result[0]:
				value = value + result[1]
				if result[1] > 0:
					need_again = true
				finish_technology.append(technology_number)
				finish = true
			else:
				pass
		for technology_number in finish_technology:
			var technology = process_technology.get_by_number(technology_number)
			now_technology.append(technology)
			process_technology.erase(technology)
	if finish:
		update_optional()
	return true
	
	
func update_optional():
	# 当某个科技完成的时候更新可选科技
	var all_optional_technology = optional_technology.get_all()
	# 将当前可选科技置为已出现
	for technology_number in all_optional_technology:
		var technology_obj=optional_technology.get_by_number(technology_number)
		technology_obj.add_appear()
	# 得到所有当前可出现的科技
	var can_optional_technology = TechnologyArray.new(null)
	
	for technology_number in all_technology.get_all():
		var technology = all_technology.get_by_number(technology_number)
		var result = check_optional(technology)
		if result[0] == false:
			# 无法选择此科技
			pass
		else:
			if result[1]==Global.DisplayType.OPTIONAL:
				# 待选科技
				can_optional_technology.append(technology)
	# 在所有待选科技中选择几个科技
	var random_technology = {}
	optional_technology = TechnologyArray.new(null)
	
	for technology_type in optional_number:
		var need_size=optional_number[technology_type]
		var random_type_technology = TechnologyArray.new(null)
		while need_size!=0:
			can_optional_technology.get_random_technology(need_size,technology_type,random_type_technology)
			random_technology[technology_type] = random_type_technology
			var begin_size = optional_technology.size()
			var add_size = random_technology[technology_type].size()
			optional_technology.update(random_technology[technology_type])
			var end_size = optional_technology.size()
			if begin_size+need_size==end_size:
				need_size=0
			else:
				need_size = begin_size + add_size - end_size
	
func check_optional(technology:Technology) -> Array:
	# 检查某个科技是否可选
	# 检查某个科技是否已出现过或者是否在研发过程中
	var displayinfo:Array = technology.check_optional()
	if displayinfo[0] == false:
		return displayinfo
	# 检查某个科技是否符合前置条件
	var need_technologies = technology.precondition
	var need_finish = true
	for need_technology_list in need_technologies:
		need_finish = true
		for need_technology in need_technology_list:
			if not get_technology(need_technology).get_finish():
				need_finish = false
				break
		if need_finish:
			break
	if not need_finish:
		# 前置条件无法满足
		return [false,Global.DisplayType.PRECONDITION_FALSE]
	var technology_rank = technology.get_rank()
	var technology_type = technology.get_technology_type()
	# 科技类别为Array
	for one_technology_type in technology_type:
		one_technology_type = int(one_technology_type)
		var now_number = now_technology.get_by_type_rank(one_technology_type,technology_rank).size()
		var process_number = process_technology.get_by_type_rank(one_technology_type,technology_rank).size()
		var max_number = optional_rank_number[one_technology_type][technology_rank]
		if max_number <= now_number + process_number:
			pass
		else:
			# 可处于待选状态
			return [true,Global.DisplayType.OPTIONAL]
	# 阶位已满
	return [false,Global.DisplayType.RANK_FULL]
	


func save_object():
	var save_dict = {
		"all_technology" : all_technology.get_all().keys(),
		"now_technology" : now_technology.get_all().keys(),
		"process_technology" : process_technology.get_all().keys(),
		"optional_technology" : optional_technology.get_all().keys(),
		"optional_number" : optional_number,
		"optional_rank_number" : optional_rank_number,
		"remaining_progress" : remaining_progress,
	}
	return save_dict

func load_object(load_dict):
	if load_dict == null:
		load_dict = {}
	var all_technology_table = load_dict.get("all_technology") if load_dict.get("all_technology") else Array(range(1,Global.TECHNOLOGY_MAX_NUMBER+1))
	all_technology=TechnologyArray.new(null)
	for k in all_technology_table:
		all_technology.append(technology_scene.instance().update_info(k))
	now_technology = load_dict.get("now_technology") if load_dict.get("now_technology") else TechnologyArray.new(null)
	for k in now_technology.get_all():
		now_technology.append(technology_scene.instance().update_info(k))
	process_technology = load_dict.get("process_technology") if load_dict.get("process_technology") else TechnologyArray.new(null)
	for k in process_technology.get_all():
		process_technology.append(technology_scene.instance().update_info(k))
	optional_technology = load_dict.get("optional_technology") if load_dict.get("optional_technology") else TechnologyArray.new(null)
	for k in optional_technology.get_all():
		optional_technology.append(technology_scene.instance().update_info(k))
	optional_number = load_dict.get("optional_number") if load_dict.get("optional_number") else recalculate_optional_number()
	optional_rank_number = load_dict.get("optional_rank_number") if load_dict.get("optional_rank_number") else recalculate_optional_rank_number()
	remaining_progress = load_dict.get("remaining_progress") if load_dict.get("remaining_progress") else 0

