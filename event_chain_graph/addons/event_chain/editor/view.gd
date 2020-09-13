tool
extends GraphEdit

var begin_pos
var end_pos
var cur_shape

var cur_time = 2
var cur_info = ""

var edit_tool_tscn = preload("edit_tool.tscn")
var edit_tool


var begin_shape 
var end_shape

func enable_edit_for(editor_node):
	pass

func clear_edit():
	pass

func _init():
	edit_tool = edit_tool_tscn.instance()
	get_zoom_hbox().add_child(edit_tool)
	pass

func _input(event):
	if edit_tool.get_now_select_type():
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
			begin_pos = get_local_mouse_position() + scroll_offset
		elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and  not event.is_pressed():
			end_pos = get_local_mouse_position()+ scroll_offset
			if not begin_pos.is_equal_approx(end_pos):
				create_shape()
				connect_shape()
				cur_shape = null
				clear_mouse_shape()
		elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
			end_pos = get_local_mouse_position()+ scroll_offset
			if not begin_pos.is_equal_approx(end_pos):
				create_shape()



func create_shape():
	match edit_tool.get_now_select_type():
		EditConstant.edit_type.IF_BRANCH:
			if cur_shape:
				cur_shape.change_end_pos(end_pos)
			else:
				cur_shape = BranchMgr.create_if_branch(begin_pos,end_pos,$CLAYER)
		EditConstant.edit_type.MATCH_BRANCH:
			if cur_shape:
				cur_shape.change_end_pos(end_pos)
			else:
				cur_shape = BranchMgr.create_match_branch(begin_pos,end_pos,$CLAYER)
		EditConstant.edit_type.DELAY_FLOW_LINE:
			if cur_shape:
				cur_shape.change_end_pos(end_pos)
			else:
				cur_shape = LineMgr.create_delay_flow_line(begin_pos,end_pos,$CLAYER,cur_time,cur_info)
			
		EditConstant.edit_type.INSTAN_FLOW_LINE:
			if cur_shape:
				cur_shape.change_end_pos(end_pos)
			else:
				cur_shape = LineMgr.create_instan_flow_line(begin_pos,end_pos,$CLAYER,cur_info)
			
		EditConstant.edit_type.REFERENCE_LINE:
			if cur_shape:
				cur_shape.change_end_pos(end_pos)
			else:
				cur_shape = LineMgr.create_reference_line(begin_pos,end_pos,$CLAYER)
	create_shape_edit_signal(cur_shape)
	
	
func create_shape_edit_signal(cur_shape):
	if cur_shape:
		cur_shape.connect("mouse_entered",self,"mouse_entered")
		cur_shape.connect("mouse_exited",self,"mouse_exited")
		
func mouse_entered(shape):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		end_shape = shape
		print(end_shape)
	
func mouse_exited(shape):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if not begin_shape:
			begin_shape = shape
			print(begin_shape)
	

func connect_shape():
	if begin_shape and end_shape:
		var first_pos = begin_shape.get_intersects_pos((begin_shape.begin_pos+begin_shape.end_pos)/2,(end_shape.begin_pos+end_shape.end_pos)/2)
		var second_pos = end_shape.get_intersects_pos((begin_shape.begin_pos+begin_shape.end_pos)/2,(end_shape.begin_pos+end_shape.end_pos)/2)
		cur_shape.change_pos(first_pos,second_pos)
		
		
func clear_mouse_shape():
	begin_shape = null
	end_shape = null


