extends Spatial
var box = preload("res://scene/Game/TicTacToe_MagicCube/Box.tscn")
var grid_panel = preload("res://scene/Game/TicTacToe_MagicCube/Grid.tscn")
var data
var select = Array()
onready var move_mode =false setget ,get_move_mode
onready var tween = $"Tween"
var button_group
var now_select_box
var now_select_box_array
var now_player
var game_AI

signal start_round
signal end_round

func _init():
	init_data()
	init_player()
	init_ai()

func _ready():
	#turn_right_clockwise()
	init_ui()
	start_round()

func init_ui():
	button_group = ButtonGroup.new()
	
	$Control/AddCube/Center/Count.text = "*3"
	$Control/AddCube/Center/Icon.group = button_group

	$Control/AddCube/Side/Count.text = "*6"
	$Control/AddCube/Side/Icon.group = button_group
	
	$Control/AddCube/Corner/Count.text = "*4"
	$Control/AddCube/Corner/Icon.group = button_group

	$Control/AddCube/CloseLock.visible=false

func get_move_mode():
	return $Control/CheckButton.is_pressed()

func init_data():
	data = MagicCubeData.MagicCube.new()
	_create_center()
	_create_side()
	_create_conrner()
	_create_thumbnail()

func init_player():
	var my_seed = "Godot"
	seed(my_seed.hash())
	match randi()%2:
		0:
			now_player = MagicCubeConstant.Player.MINE
		1:
			now_player = MagicCubeConstant.Player.OTHER

func init_ai():
	game_AI = AIManage.create_gameAI("MagicCube")
	game_AI.control_game = self

func _create_center():
	var centerbox = box.instance()
	var centerbox_data = data.down.get_center()
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,-2,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.left.get_center()
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,0,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.right.get_center()
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,0,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.get_center()
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,2,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.front.get_center()
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,0,2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.behind.get_center()
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,0,-2)
	centerbox.init_signal(self)
	
func _create_side():
	var centerbox = box.instance()
	var centerbox_data = data.down.cx.y
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cz.y
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,-2,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.down.cz.y
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cx.y
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,-2,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.down.cy.z
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cy.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,-2,2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.down.cy.x
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cy.z
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,-2,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cx.y
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cz.y
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,2,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cz.y
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cx.y
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,2,0)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cy.x
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cy.x
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,2,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cy.z
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cy.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(0,2,2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.front.cx.y
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cy.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,0,2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.front.cz.y
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cy.z
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,0,2)
	centerbox.init_signal(self)

	centerbox = box.instance()
	centerbox_data = data.behind.cx.y
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cy.x
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,0,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.behind.cz.y
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cy.x
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,0,-2)
	centerbox.init_signal(self)
	
func _create_conrner():
	var centerbox = box.instance()
	var centerbox_data = data.down.cx.x
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cz.x
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cx.z
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,-2,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.down.cz.x
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cx.x
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cz.z
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,-2,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.down.cx.z
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cz.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cx.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,-2,2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.down.cz.z
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cx.z
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cz.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,-2,2)
	centerbox.init_signal(self)

	centerbox = box.instance()
	centerbox_data = data.up.cz.x
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cx.x
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cx.x
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,2,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cx.x
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cz.x
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cz.x
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,2,-2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cx.z
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cz.z
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cz.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(2,2,2)
	centerbox.init_signal(self)
	
	centerbox = box.instance()
	centerbox_data = data.up.cz.z
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cx.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cx.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,2,2)
	centerbox.init_signal(self)


func turn_right_clockwise():
	if get_move_mode():
		turn_cube_right_clockwise()
	else:
		# 旋转
		for grid in data.right:
			get_node("%s_%s"%[grid.type, grid.number]).turn_right_clockwise()
	
		# 更新数据
		data.turn_right_clockwise()
	
func turn_right_anit():
	if get_move_mode():
		turn_cube_right_anit()
	else:
		# 旋转
		for grid in data.right:
			get_node("%s_%s"%[grid.type, grid.number]).turn_right_anit()
	
		# 更新数据
		data.turn_right_anit()

func turn_left_clockwise():
	if get_move_mode():
		turn_cube_left_clockwise()
	else:
		# 旋转
		for grid in data.left:
			get_node("%s_%s"%[grid.type, grid.number]).turn_left_clockwise()
	
		# 更新数据
		data.turn_left_clockwise()
	
func turn_left_anit():
	if get_move_mode():
		turn_cube_left_anit()
	else:
		# 旋转
		for grid in data.left:
			get_node("%s_%s"%[grid.type, grid.number]).turn_left_anit()
	
		# 更新数据
		data.turn_left_anit()

func turn_up_clockwise():
	if get_move_mode():
		turn_cube_up_clockwise()
	else:
		# 旋转
		for grid in data.up:
			get_node("%s_%s"%[grid.type, grid.number]).turn_up_clockwise()
	
		# 更新数据
		data.turn_up_clockwise()
	
func turn_up_anit():
	if get_move_mode():
		turn_cube_up_anit()
	else:
		# 旋转
		for grid in data.up:
			get_node("%s_%s"%[grid.type, grid.number]).turn_up_anit()
	
		# 更新数据
		data.turn_up_anit()
	
func turn_down_clockwise():
	if get_move_mode():
		turn_cube_down_clockwise()
	else:
		# 旋转
		for grid in data.down:
			get_node("%s_%s"%[grid.type, grid.number]).turn_down_clockwise()
	
		# 更新数据
		data.turn_down_clockwise()
	
func turn_down_anit():
	if get_move_mode():
		turn_cube_down_anit()
	else:
		# 旋转
		for grid in data.down:
			get_node("%s_%s"%[grid.type, grid.number]).turn_down_anit()
	
		# 更新数据
		data.turn_down_anit()

func turn_front_clockwise():
	if get_move_mode():
		turn_cube_front_clockwise()
	else:
		# 旋转
		for grid in data.front:
			get_node("%s_%s"%[grid.type, grid.number]).turn_front_clockwise()
	
		# 更新数据
		data.turn_front_clockwise()
	
func turn_front_anit():
	if get_move_mode():
		turn_cube_front_anit()
	else:
		# 旋转
		for grid in data.front:
			get_node("%s_%s"%[grid.type, grid.number]).turn_front_anit()
	
		# 更新数据
		data.turn_front_anit()
	
func turn_behind_clockwise():
	if get_move_mode():
		turn_cube_behind_clockwise()
	else:
		# 旋转
		for grid in data.behind:
			get_node("%s_%s"%[grid.type, grid.number]).turn_behind_clockwise()
	
		# 更新数据
		data.turn_behind_clockwise()
	
func turn_behind_anit():
	if get_move_mode():
		turn_cube_behind_anit()
	else:
	# 旋转
		for grid in data.behind:
			get_node("%s_%s"%[grid.type, grid.number]).turn_behind_anit()
	
		# 更新数据
		data.turn_behind_anit()
	
func turn_transverse_clockwise():
	if get_move_mode():
		turn_cube_front_clockwise()
	else:
		# 沿着底部横向中间线做旋转
		turn_front_anit()
		turn_behind_clockwise()
	
func turn_transverse_anit():
	if get_move_mode():
		turn_cube_front_anit()
	else:
		# 沿着底部横向中间线做旋转
		turn_front_clockwise()
		turn_behind_anit()
	
func turn_longitudinal_clockwise():
	if get_move_mode():
		turn_cube_right_clockwise()
	else:
		# 沿着底部纵向中间线做旋转
		turn_right_anit()
		turn_left_clockwise()
	
func turn_longitudinal_anit():
	if get_move_mode():
		turn_cube_right_anit()
	else:
		# 沿着底部纵向中间线做旋转
		turn_right_clockwise()
		turn_left_anit()

func turn_center_clockwise():
	if get_move_mode():
		turn_cube_down_clockwise()
	else:
		# 沿着非底部做旋转
		turn_down_anit()
		turn_up_clockwise()
	
func turn_center_anit():
	if get_move_mode():
		turn_cube_down_anit()
	else:
		# 沿着非底部做旋转
		turn_down_clockwise()
		turn_up_anit()

func box_panel_entered(panel_name):
	if now_player == MagicCubeConstant.Player.MINE:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			select.append(panel_name)

func box_panel_exited(panel_name):
	if now_player == MagicCubeConstant.Player.MINE:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and select.empty():
			select.append(panel_name)


func box_panel_input_event(camera, event, click_position, click_normal, shape_idx,panel_name):
	if now_player == MagicCubeConstant.Player.MINE:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and select.empty():
			select.append(panel_name)

func _input(event):
	if now_player == MagicCubeConstant.Player.MINE:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed == false:
				generateAction()
			
func generateAction():
	# 根据矩阵生成动作
	var action = ""
	match select.size():
		3:
			action = get_action_three()
		8:
			action = get_action_eight()
		1:
			do_action_one()
		_:
			select.clear()
			return 
	# 做动作
	var neednext = false
	if action:
		call(action)
		if get_move_mode():
			pass
		else:
			neednext = true
	# 清空当前选择项目
	select.clear()
	
	# 更新缩略图
	_update_grid_panel()
	
	if neednext:
		next_round()

func do_action_one():
	var inpanel = data.get_in_panel(select)
	if not inpanel:
		return false
	if not get_now_pressed():
		return false
	var grid = inpanel.get_grid_by_name(select[0])
	var grid_list = Array()
	match grid.type:
		MagicCubeConstant.GridType.CENTER:
			if get_now_pressed()!= "Center":
				return false
			grid_list.append("%s_%s_%s"%[grid.type,grid.number,0])
		MagicCubeConstant.GridType.SIDE:
			if get_now_pressed()!= "Side":
				return false
			grid_list.append("%s_%s_%s"%[grid.type,grid.number,0])
			grid_list.append("%s_%s_%s"%[grid.type,grid.number,1])
		MagicCubeConstant.GridType.CORNER:
			if get_now_pressed()!= "Corner":
				return false
			grid_list.append("%s_%s_%s"%[grid.type,grid.number,0])
			grid_list.append("%s_%s_%s"%[grid.type,grid.number,1])
			grid_list.append("%s_%s_%s"%[grid.type,grid.number,2])
	if now_select_box_array == grid_list:
		# 改变格子内的内容
		var box_node =get_node("%s_%s"%[grid.type,grid.number])
		box_node
		var i = 0
		var one_type = data.grid_map[grid_list[0]]
		for value in grid_list:
			if i ==len(grid_list)-1:
				data.grid_map[value] = one_type
			else:
				data.grid_map[value] = data.grid_map[grid_list[i+1]]
			i+=1
		now_select_box = box_node
		now_select_box_array = grid_list
	else:
		if now_select_box_array:
			# 清空格子内的内容
			for value in now_select_box_array:
				data.grid_map.erase(value)
			now_select_box.clear_panel(now_select_box_array)
		else:
			pass
		var box_node =get_node("%s_%s"%[grid.type,grid.number])
		box_node
		var i = 0
		for value in grid_list:
			if i%2==0:
				data.grid_map[value] = MagicCubeConstant.Data.CROSS
			else:
				data.grid_map[value] = MagicCubeConstant.Data.RING
			i+=1
		now_select_box = box_node
		now_select_box_array = grid_list
	now_select_box.update_panel(data.grid_map,now_select_box_array)
		
func get_action_three():
	var inpanel = data.get_in_panel(select)
	if not inpanel:
		return false
	
	var action_name = ""
	var begin = select[0].split("_")
	var center = select[1].split("_")
	var end = select[2].split("_")
	
	var turn_name = ""
	match [int(begin[0]),int(center[0]),int(end[0])]:
		[MagicCubeConstant.GridType.CORNER,MagicCubeConstant.GridType.SIDE,MagicCubeConstant.GridType.CORNER]:
			# 边角直线
			if inpanel.cx.equal_string_array(select):
				turn_name="cx_down"
			elif inpanel.cx.zyx.equal_string_array(select):
				turn_name="cx_up"
			elif inpanel.cz.equal_string_array(select):
				turn_name="cz_down"
			elif inpanel.cz.zyx.equal_string_array(select):
				turn_name="cz_up"
			elif inpanel.ri.equal_string_array(select):
				turn_name="ri_right"
			elif inpanel.ri.zyx.equal_string_array(select):
				turn_name="ri_left"
			elif inpanel.rk.equal_string_array(select):
				turn_name="rk_right"
			elif inpanel.rk.zyx.equal_string_array(select):
				turn_name="rk_left"
		[MagicCubeConstant.GridType.SIDE,MagicCubeConstant.GridType.CENTER,MagicCubeConstant.GridType.SIDE]:
			# 中间直线
			if inpanel.cy.equal_string_array(select):
				turn_name="cy_down"
			elif inpanel.cy.zyx.equal_string_array(select):
				turn_name="cy_up"
			elif inpanel.rj.equal_string_array(select):
				turn_name="rj_right"
			elif inpanel.rj.zyx.equal_string_array(select):
				turn_name="rj_left"
		_:
			pass
	match [inpanel,turn_name]:
		[data.down,"cx_down"]:
			action_name = "turn_left_anit"
		[data.down,"cx_up"]:
			action_name = "turn_left_clockwise"
		[data.down,"cy_down"]:
			action_name = "turn_longitudinal_clockwise"
		[data.down,"cy_up"]:
			action_name = "turn_longitudinal_anit"
		[data.down,"cz_down"]:
			action_name = "turn_right_clockwise"
		[data.down,"cz_up"]:
			action_name = "turn_right_anit"
			
		[data.down,"ri_right"]:
			action_name = "turn_behind_clockwise"
		[data.down,"ri_left"]:
			action_name = "turn_behind_anit"
		[data.down,"rj_right"]:
			action_name = "turn_transverse_anit"
		[data.down,"rj_left"]:
			action_name = "turn_transverse_clockwise"
		[data.down,"rk_right"]:
			action_name = "turn_front_anit"
		[data.down,"rk_left"]:
			action_name = "turn_front_clockwise"
			
		[data.up,"cx_down"]:
			action_name = "turn_right_anit"
		[data.up,"cx_up"]:
			action_name = "turn_right_clockwise"
		[data.up,"cy_down"]:
			action_name = "turn_longitudinal_anit"
		[data.up,"cy_up"]:
			action_name = "turn_longitudinal_clockwise"
		[data.up,"cz_down"]:
			action_name = "turn_left_clockwise"
		[data.up,"cz_up"]:
			action_name = "turn_left_anit"
			
		[data.up,"ri_right"]:
			action_name = "turn_behind_clockwise"
		[data.up,"ri_left"]:
			action_name = "turn_behind_anit"
		[data.up,"rj_right"]:
			action_name = "turn_transverse_anit"
		[data.up,"rj_left"]:
			action_name = "turn_transverse_clockwise"
		[data.up,"rk_right"]:
			action_name = "turn_front_anit"
		[data.up,"rk_left"]:
			action_name = "turn_front_clockwise"	
			
		[data.right,"cx_down"]:
			action_name = "turn_down_anit"
		[data.right,"cx_up"]:
			action_name = "turn_down_clockwise"
		[data.right,"cy_down"]:
			action_name = "turn_center_anit"
		[data.right,"cy_up"]:
			action_name = "turn_center_clockwise"
		[data.right,"cz_down"]:
			action_name = "turn_up_clockwise"
		[data.right,"cz_up"]:
			action_name = "turn_up_anit"
			
		[data.right,"ri_right"]:
			action_name = "turn_behind_clockwise"
		[data.right,"ri_left"]:
			action_name = "turn_behind_anit"
		[data.right,"rj_right"]:
			action_name = "turn_transverse_anit"
		[data.right,"rj_left"]:
			action_name = "turn_transverse_clockwise"
		[data.right,"rk_right"]:
			action_name = "turn_front_anit"
		[data.right,"rk_left"]:
			action_name = "turn_front_clockwise"
			
		[data.left,"cx_down"]:
			action_name = "turn_up_anit"
		[data.left,"cx_up"]:
			action_name = "turn_up_clockwise"
		[data.left,"cy_down"]:
			action_name = "turn_center_clockwise"
		[data.left,"cy_up"]:
			action_name = "turn_center_anit"
		[data.left,"cz_down"]:
			action_name = "turn_down_clockwise"
		[data.left,"cz_up"]:
			action_name = "turn_down_anit"
			
		[data.left,"ri_right"]:
			action_name = "turn_behind_clockwise"
		[data.left,"ri_left"]:
			action_name = "turn_behind_anit"
		[data.left,"rj_right"]:
			action_name = "turn_transverse_anit"
		[data.left,"rj_left"]:
			action_name = "turn_transverse_clockwise"
		[data.left,"rk_right"]:
			action_name = "turn_front_anit"
		[data.left,"rk_left"]:
			action_name = "turn_front_clockwise"	
			
		[data.front,"cx_down"]:
			action_name = "turn_left_anit"
		[data.front,"cx_up"]:
			action_name = "turn_left_clockwise"
		[data.front,"cy_down"]:
			action_name = "turn_longitudinal_clockwise"
		[data.front,"cy_up"]:
			action_name = "turn_longitudinal_anit"
		[data.front,"cz_down"]:
			action_name = "turn_right_clockwise"
		[data.front,"cz_up"]:
			action_name = "turn_right_anit"
			
		[data.front,"ri_right"]:
			action_name = "turn_down_clockwise"
		[data.front,"ri_left"]:
			action_name = "turn_down_anit"
		[data.front,"rj_right"]:
			action_name = "turn_center_clockwise"
		[data.front,"rj_left"]:
			action_name = "turn_center_anit"
		[data.front,"rk_right"]:
			action_name = "turn_up_anit"
		[data.front,"rk_left"]:
			action_name = "turn_up_clockwise"	
			
		[data.behind,"cx_down"]:
			action_name = "turn_left_anit"
		[data.behind,"cx_up"]:
			action_name = "turn_left_clockwise"
		[data.behind,"cy_down"]:
			action_name = "turn_longitudinal_clockwise"
		[data.behind,"cy_up"]:
			action_name = "turn_longitudinal_anit"
		[data.behind,"cz_down"]:
			action_name = "turn_right_clockwise"
		[data.behind,"cz_up"]:
			action_name = "turn_right_anit"
			
		[data.behind,"ri_right"]:
			action_name = "turn_up_clockwise"
		[data.behind,"ri_left"]:
			action_name = "turn_up_anit"
		[data.behind,"rj_right"]:
			action_name = "turn_center_anit"
		[data.behind,"rj_left"]:
			action_name = "turn_center_clockwise"
		[data.behind,"rk_right"]:
			action_name = "turn_down_anit"
		[data.behind,"rk_left"]:
			action_name = "turn_down_clockwise"	
	return action_name
	
func get_action_eight():
	var inpanel = data.get_in_panel(select)
	if not inpanel:
		return false
	var action_name = ""
	if inpanel.equal_panel_anit(select):
		action_name = "anit"
	elif inpanel.equal_panel_clockwise(select):
		action_name = "clockwise"
	if action_name != "":
		match inpanel:
			data.down:
				action_name = "turn_down_"+action_name
			data.up:
				action_name = "turn_up_"+action_name
			data.behind:
				action_name = "turn_behind_"+action_name
			data.front:
				action_name = "turn_front_"+action_name
			data.left:
				action_name = "turn_left_"+action_name
			data.right:
				action_name = "turn_right_"+action_name
	return action_name

func _create_thumbnail():
	_create_one_panel(data.up,Vector2(-2,0),"up")
	_create_one_panel(data.down,Vector2(0,0),"down")
	_create_one_panel(data.left,Vector2(-1,0),"left")
	_create_one_panel(data.right,Vector2(1,0),"right")
	_create_one_panel(data.front,Vector2(0,1),"front")
	_create_one_panel(data.behind,Vector2(0,-1),"behind")
	
func _create_one_panel(panel,offset,panel_name):
	var i = 0
	for grid_data in panel:
		var grid = grid_panel.instance()
		grid.label = grid_data.to_string()
		add_child(grid)
		grid.name = panel_name+String(i)
		
		var size = grid.rect_size
		var x = i%3
		var y = floor(i/3)
		x += offset.x*3
		y += offset.y*3
		
		x += 2*3
		y += 1*3
		grid.rect_position = Vector2(x*size.x,y*size.y)
		i += 1
		
func _update_grid_panel():
	_update_one_panel(data.up,"up")
	_update_one_panel(data.down,"down")
	_update_one_panel(data.left,"left")
	_update_one_panel(data.right,"right")
	_update_one_panel(data.front,"front")
	_update_one_panel(data.behind,"behind")

func _update_one_panel(panel,panel_name):
	var i = 0
	for grid_data in panel:
		var grid = get_node(panel_name+String(i))
		var grid_flag = data.grid_map.get(grid_data.to_string(),grid_data.to_string())
		var grid_label
		match grid_flag:
			MagicCubeConstant.Data.RING:
				grid_label = "O"
			MagicCubeConstant.Data.CROSS:
				grid_label = "X"
			_:
				grid_label = grid_flag
		
		if grid.label == grid_label:
			grid.color=Color.white
		else:
			grid.color=Color.red
			grid.label = grid_label
		i += 1


var tween_turn_right_left_rotation = 0
func tween_turn_right_left(rotation):
	var needrotation = 0
	if tween_turn_right_left_rotation != 0 :
		needrotation = rotation - tween_turn_right_left_rotation
		tween_turn_right_left_rotation = rotation
	else:
		needrotation = rotation
		tween_turn_right_left_rotation = rotation
		
	transform=transform*Transform(Basis(Vector3(1,0,0),needrotation))
	
func turn_cube_right_clockwise():
	tween_turn_right_left_rotation = 0
	tween.interpolate_method(self, "tween_turn_right_left", 0, -TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func turn_cube_right_anit():
	tween_turn_right_left_rotation = 0
	tween.interpolate_method(self, "tween_turn_right_left", 0, TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func turn_cube_left_clockwise():
	tween_turn_right_left_rotation = 0
	tween.interpolate_method(self, "tween_turn_right_left", 0, TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func turn_cube_left_anit():
	tween_turn_right_left_rotation = 0
	tween.interpolate_method(self, "tween_turn_right_left", 0, -TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
var tween_turn_up_down_rotation = 0
func tween_turn_up_down(rotation):
	var needrotation = 0
	if tween_turn_up_down_rotation != 0 :
		needrotation = rotation - tween_turn_up_down_rotation
		tween_turn_up_down_rotation = rotation
	else:
		needrotation = rotation
		tween_turn_up_down_rotation = rotation
		
	transform=transform*Transform(Basis(Vector3(0,1,0),needrotation))
	
func turn_cube_up_clockwise():
	tween_turn_up_down_rotation = 0
	tween.interpolate_method(self, "tween_turn_up_down", 0, -TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func turn_cube_up_anit():
	tween_turn_up_down_rotation = 0
	tween.interpolate_method(self, "tween_turn_up_down", 0, TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)	
	if not tween.is_active():
		tween.start()
		
func turn_cube_down_clockwise():
	tween_turn_up_down_rotation = 0
	tween.interpolate_method(self, "tween_turn_up_down", 0, TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func turn_cube_down_anit():
	tween_turn_up_down_rotation = 0
	tween.interpolate_method(self, "tween_turn_up_down", 0, -TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

var tween_turn_front_behind_rotation = 0
func tween_turn_front_behind(rotation):
	var needrotation = 0
	if tween_turn_front_behind_rotation != 0 :
		needrotation = rotation - tween_turn_front_behind_rotation
		tween_turn_front_behind_rotation = rotation
	else:
		needrotation = rotation
		tween_turn_front_behind_rotation = rotation
		
	transform=transform*Transform(Basis(Vector3(0,0,1),needrotation))

func turn_cube_front_clockwise():
	tween_turn_front_behind_rotation = 0
	tween.interpolate_method(self, "tween_turn_front_behind", 0, -TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
			
func turn_cube_front_anit():
	tween_turn_front_behind_rotation = 0
	tween.interpolate_method(self, "tween_turn_front_behind", 0, TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
	
func turn_cube_behind_clockwise():
	tween_turn_front_behind_rotation = 0
	tween.interpolate_method(self, "tween_turn_front_behind", 0, TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func turn_cube_behind_anit():
	tween_turn_front_behind_rotation = 0
	tween.interpolate_method(self, "tween_turn_front_behind", 0, -TAU/4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()


	$Option2.connect("toggled", self, "_on_Option_toggled")
	
var last_pressed  = null

func _on_option_toggled(button_pressed: bool) -> void:
	if now_player == MagicCubeConstant.Player.MINE:
		if button_pressed:
			var pressed_button  = button_group.get_pressed_button()
			if last_pressed == pressed_button:
				pressed_button.pressed = false
				last_pressed = null
				$Control/AddCube/CloseLock.visible=false
			else:
				last_pressed = pressed_button
				$Control/AddCube/CloseLock.visible=true
	else:
		var pressed_button  = button_group.get_pressed_button()
		if pressed_button:
			pressed_button.pressed = false

func get_now_pressed():
	var select_name
	var select_button = button_group.get_pressed_button()
	var side_button = $Control/AddCube/Side/Icon
	var center_button = $Control/AddCube/Center/Icon
	var corner_button = $Control/AddCube/Corner/Icon
	
	match select_button:
		side_button:
			select_name = "Side"
		center_button:
			select_name = "Center"
		corner_button:
			select_name = "Corner"
	return select_name

func _on_close_pressed():
	if now_select_box_array:
		# 清空格子内的内容
		for value in now_select_box_array:
			data.grid_map.erase(value)
		now_select_box.clear_panel(now_select_box_array)
		now_select_box_array = null
		now_select_box = null
		_update_grid_panel()
	$Control/AddCube/CloseLock.visible=false
	last_pressed = null
	var select_button = button_group.get_pressed_button()
	if select_button:
		select_button.pressed=false
		
	
func _on_lock_pressed():
	now_select_box = null
	now_select_box_array = null
	$Control/AddCube/CloseLock.visible=false
	last_pressed = null
	var select_button = button_group.get_pressed_button()
	if select_button:
		select_button.pressed=false
		
	next_round()

func next_round():
	end_round()
	start_round()
	
func start_round():
	if now_player == MagicCubeConstant.Player.MINE:
		pass
	elif now_player == MagicCubeConstant.Player.OTHER:
		game_AI.start_AI()
	
	var select_button = button_group.get_pressed_button()
	if select_button:
		select_button.pressed=false
		last_pressed = null
		$Control/AddCube/CloseLock.visible=false
	
	# 发射信号
	emit_signal("start_round")

func end_round():
	if now_player == MagicCubeConstant.Player.MINE:
		pass
	elif now_player == MagicCubeConstant.Player.OTHER:
		game_AI.end_AI()
	
	now_player = (now_player+1)%2
	
	var select_button = button_group.get_pressed_button()
	if select_button:
		select_button.pressed=false
		last_pressed = null
		$Control/AddCube/CloseLock.visible=false
	# 发射信号
	emit_signal("end_round")
