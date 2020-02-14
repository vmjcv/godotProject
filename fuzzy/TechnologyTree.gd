extends Control
var technology = preload("res://Technology.tscn")
var technology_bg = preload("res://Technology_BG.tscn")
var technology_rank = preload("res://TechnologyRank.tscn")

onready var descent = get_node("BaseContainer/ThreeTree/Descent")
onready var science = get_node("BaseContainer/ThreeTree/Science")
onready var magic = get_node("BaseContainer/ThreeTree/Magic")

onready var first_line = get_node("BaseContainer/CenterContainer/VBoxContainer/CenterContainer2/FirstLine")
onready	var second_line = get_node("BaseContainer/CenterContainer/VBoxContainer/CenterContainer/SecondLine")
	

onready var node_map={
	Global.TechnologyType.DESCENT:descent,
	Global.TechnologyType.SCIENCE:science,
	Global.TechnologyType.MAGIC:magic,
}

func _ready():
	TechnologyManage.connect("technology_click_update", self, "update_technology_bg")

	update_slot()
	update_now_technology() # 更新树上已有的科技
	update_process_technology() # 更新树上正在研发的科技
	update_optional_technology() # 更新当前可选的科技
	
	# 测试代码
	TechnologyManage.update_optional()
	update_optional_technology()
	
	# add_technology(TechnologyManage.all_technology.get_by_number(2))

func update_technology_bg():
	# 更新所有槽位的背景
	var node_bg=get_tree().get_nodes_in_group("TechnologyBG")
	for node in node_bg:
		node.update_styles()

func update_now_technology():
	var now_technology=TechnologyManage.now_technology.get_all()
	for number in now_technology:
		add_technology(now_technology[number])

func update_process_technology():
	var process_technology=TechnologyManage.process_technology.get_all()
	for number in process_technology:
		add_technology(process_technology[number])
		
func update_optional_technology():
	var optional_technology=TechnologyManage.optional_technology.get_all()
	var i=1
	for number in optional_technology:
		add_optional_technology(optional_technology[number],i)
		i=i+1
	pass
	
func add_optional_technology(technology_object,i):
	var add_line=first_line if i<=5 else second_line
	add_line.add_child(technology_object)

func add_technology(technology_object):
	var rank = technology_object.rank
	var technology_type = technology_object.select_technology_type
	technology_object.rect_min_size =Vector2(60,60)
	technology_object.rect_size=Vector2(60,60)
	technology_object.update_info(technology_object.number)
	var node_bg=get_tree().get_nodes_in_group("TechnologyBG_%s_%s"%[technology_type,rank])
	for node in node_bg:
		if node.get_child_count()==0:
			node.add_child(technology_object)
			node.technology_object = technology_object
			node.update_styles()
			break

func update_slot():
	# 更新科技树的槽位
	var optional_rank_number=TechnologyManage.recalculate_optional_rank_number()
	for technology_type in optional_rank_number:
		var root_node = node_map[technology_type]
		var rank_tree = optional_rank_number[technology_type]
		for rank in rank_tree:
			var node = technology_rank.instance()
			node.name="Rank%s"%rank
			root_node.add_child(node)
			for i in range(1,rank_tree[rank]+1):
				var technology_node = technology_bg.instance()
				technology_node.rect_min_size =Vector2(60,60)
				technology_node.rect_size =Vector2(60,60)
				node.get_node("IconPanel").add_child(technology_node)
				technology_node.name="TechnologyBG%s"%i
				technology_node.add_to_group("TechnologyBG_%s_%s"%[technology_type,rank])
				technology_node.add_to_group("TechnologyBG")
				technology_node.technology_type=technology_type
				technology_node.rank=rank
			
	

