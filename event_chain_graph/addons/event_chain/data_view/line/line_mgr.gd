tool
extends Node
var line_tscn = preload("res://addons/event_chain/data_view/line/line.tscn")

var line_dict = {}
var line_number = 0 

func _ready():
	pass
	
func create_line(type,begin_pos,end_pos,begin_color,end_color,add_to=null,line_name=null,time=null,info=null):
	var line = line_tscn.instance()
	line.draw(type,begin_pos,end_pos,begin_color,end_color,time,info)
	if line_name:
		line.name = line_name
		line_dict[line.name] = line
	else:
		line.name = str(line_number)
		line_number = line_number+1
		line_dict[line.name] = line
	
	if add_to:
		add_to.add_child(line)
	return line
	
func delete_line(line_name=null):
	if line_name:
		line_dict[line_name].queue_free()
		line_dict.erase(line_name)
	else:
		while line_number-1>=0:
			if line_dict[str(line_number-1)]:
				line_dict[str(line_number-1)].queue_free()
				line_dict.erase(str(line_number-1))
				line_number = line_number-1
				break

func create_reference_line(begin_pos,end_pos,add_to):
	return create_line(LineConstant.line_type.DOTTED,begin_pos,end_pos,Color.white,Color.white,add_to,null,null,null)

func create_instan_flow_line(begin_pos,end_pos,add_to,info=null):
	return create_line(LineConstant.line_type.SOLID,begin_pos,end_pos,Color.black,Color.black,add_to,null,null,info)

func create_delay_flow_line(begin_pos,end_pos,add_to,time=null,info=null):
	return create_line(LineConstant.line_type.SOLID,begin_pos,end_pos,Color.blue,Color.blue,add_to,null,time,info)

