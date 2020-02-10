class_name TechnologyManage
extends Node
# 科技管理器，每次研发完成可以重新更新可研发科技
var all_technology:TechnologyArray # 所有科技
var now_technology:TechnologyArray # 当前已研发完成科技
var process_technology:TechnologyArray # 当前正在研发科技
var optional_technology:TechnologyArray # 当前可选科技
var appear_technology:Array # 已出现科技
var optional_number:Dictionary # 可选科技数量，[3,4,3]
var remaining_progress:float # 剩余进度点



func _init():
	var player_info = Global.player_info.get_technology_info()
	all_technology = player_info.all_technology
	now_technology =  player_info.now_technology
	process_technology = player_info.process_technology
	optional_technology = player_info.optional_technology
	appear_technology = player_info.appear_technology
	optional_number = player_info.optional_number
	remaining_progress = player_info.remaining_progress
	
	
func get_technology(technlogy_number):
	return all_technology[technlogy_number]
	
	
func add_progress(value):
	value = remaining_progress + value
	var need_again = true
	var finish = false
	if need_again:
		need_again = false
		var finish_technology := [] #完成的科技
		var once_add = value/process_technology.size()
		var all_process_technology = process_technology.get_all()
		for technology_number in all_process_technology:
			var result = all_process_technology[technology_number].add_progress(once_add)
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
			var technology = all_process_technology[technology_number]
			now_technology.append(technology)
			process_technology.erase(technology)
	if finish:
		update_optional()
	return true
	
	
func update_optional():
	# 当某个科技完成的时候更新可选科技
	var all_optional_technology = optional_technology.get_all()
	for technology_number in all_optional_technology:
		
		pass
	pass
	
	
	
	
	
	
	
	
	
	
	
	



































