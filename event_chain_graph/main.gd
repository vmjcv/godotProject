extends GraphEdit

var begin_pos
var end_pos
var cur_edit

var cur_time = 0
var cur_info = ""

var edit_tool_tscn = preload("res://edit_tool.tscn")
var edit_tool

func _ready():
	edit_tool = edit_tool_tscn.instance()
	get_zoom_hbox().add_child(edit_tool)
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		begin_pos = event.position + scroll_offset
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and  not event.is_pressed():
		end_pos = event.position+ scroll_offset
		if not begin_pos.is_equal_approx(end_pos):
			create_shape()
			cur_edit = null
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		end_pos = event.position+ scroll_offset
		if not begin_pos.is_equal_approx(end_pos):
			create_shape()


func create_shape():
	match edit_tool.get_now_select_type():
		EditConstant.edit_type.BRANCH:
			if cur_edit:
				cur_edit.change_end_pos(end_pos)
			else:
				cur_edit = BranchMgr.create_decision(begin_pos,end_pos,$CLAYER)
		EditConstant.edit_type.DELAY_FLOW_LINE:
			if cur_edit:
				cur_edit.change_end_pos(end_pos)
			else:
				cur_edit = LineMgr.create_delay_flow_line(begin_pos,end_pos,$CLAYER,cur_time,cur_info)
			
		EditConstant.edit_type.INSTAN_FLOW_LINE:
			if cur_edit:
				cur_edit.change_end_pos(end_pos)
			else:
				cur_edit = LineMgr.create_instan_flow_line(begin_pos,end_pos,$CLAYER,cur_info)
			
		EditConstant.edit_type.REFERENCE_LINE:
			if cur_edit:
				cur_edit.change_end_pos(end_pos)
			else:
				cur_edit = LineMgr.create_reference_line(begin_pos,end_pos,$CLAYER)
			
