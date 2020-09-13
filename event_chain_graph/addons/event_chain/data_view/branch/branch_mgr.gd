tool
extends Node
var branch_tscn = preload("res://addons/event_chain/data_view/branch/branch.tscn")

var branch_dict = {}
var branch_number = 0 

func _ready():
	pass
	
func create_branch(type,begin_pos,end_pos,rect_color,add_to=null,branch_name=null,info=null):
	var branch = branch_tscn.instance()
	branch.draw(type,begin_pos,end_pos,rect_color,info)
	if branch_name:
		branch.name = branch_name
		branch_dict[branch.name] = branch
	else:
		branch.name = str(branch_number)
		branch_number = branch_number+1
		branch_dict[branch.name] = branch
	
	if add_to:
		add_to.add_child(branch)
		
	return branch
	
func delete_branch(branch_name=null):
	if branch_name:
		branch_dict[branch_name].queue_free()
		branch_dict.erase(branch_name)
	else:
		while branch_number-1>=0:
			if branch_dict[str(branch_number-1)]:
				branch_dict[str(branch_number-1)].queue_free()
				branch_dict.erase(str(branch_number-1))
				branch_number = branch_number-1
				break


func create_if_branch(begin_pos,end_pos,add_to):
	return create_branch(BranchConstant.branch_type.IF,begin_pos,end_pos,Color.white,add_to)
	
func create_match_branch(begin_pos,end_pos,add_to):
	return create_branch(BranchConstant.branch_type.MATCH,begin_pos,end_pos,Color.white,add_to)
