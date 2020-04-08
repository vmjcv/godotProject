extends Spatial
var box = preload("res://scene/Game/TicTacToe_MagicCube/Box.tscn")
var data
var select = Array()
func _init():
	init_data()

func _ready():
	
	#turn_right_clockwise()
	pass

func init_data():
	data = MagicCubeData.MagicCube.new()
	_create_center()
	_create_side()
	_create_conrner()

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
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
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
	centerbox_data = data.left.cz.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cx.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.name = "%s_%s"%[centerbox_data.type, centerbox_data.number]
	centerbox.translation=Vector3(-2,2,2)
	centerbox.init_signal(self)


func turn_right_clockwise():
	# 旋转
	for grid in data.right:
		get_node("%s_%s"%[grid.type, grid.number]).turn_right_clockwise()

	# 更新数据
	data.turn_right_clockwise()
	
func turn_right_anit():
	# 旋转
	for grid in data.right:
		get_node("%s_%s"%[grid.type, grid.number]).turn_right_anit()

	# 更新数据
	data.turn_right_anit()

func turn_left_clockwise():
	# 旋转
	for grid in data.left:
		get_node("%s_%s"%[grid.type, grid.number]).turn_left_clockwise()

	# 更新数据
	data.turn_left_clockwise()
	
func turn_left_anit():
	# 旋转
	for grid in data.left:
		get_node("%s_%s"%[grid.type, grid.number]).turn_left_anit()

	# 更新数据
	data.turn_left_anit()

func turn_up_clockwise():
	# 旋转
	for grid in data.up:
		get_node("%s_%s"%[grid.type, grid.number]).turn_up_clockwise()

	# 更新数据
	data.turn_up_clockwise()
	
func turn_up_anit():
	# 旋转
	for grid in data.up:
		get_node("%s_%s"%[grid.type, grid.number]).turn_up_anit()

	# 更新数据
	data.turn_up_anit()
	
func turn_down_clockwise():
	# 旋转
	for grid in data.down:
		get_node("%s_%s"%[grid.type, grid.number]).turn_down_clockwise()

	# 更新数据
	data.turn_down_clockwise()
	
func turn_down_anit():
	# 旋转
	for grid in data.down:
		get_node("%s_%s"%[grid.type, grid.number]).turn_down_anit()

	# 更新数据
	data.turn_down_anit()

func turn_front_clockwise():
	# 旋转
	for grid in data.front:
		get_node("%s_%s"%[grid.type, grid.number]).turn_front_clockwise()

	# 更新数据
	data.turn_front_clockwise()
	
func turn_front_anit():
	# 旋转
	for grid in data.front:
		get_node("%s_%s"%[grid.type, grid.number]).turn_front_anit()

	# 更新数据
	data.turn_front_anit()
	
func turn_behind_clockwise():
	# 旋转
	for grid in data.behind:
		get_node("%s_%s"%[grid.type, grid.number]).turn_behind_clockwise()

	# 更新数据
	data.turn_behind_clockwise()
	
func turn_behind_anit():
	# 旋转
	for grid in data.behind:
		get_node("%s_%s"%[grid.type, grid.number]).turn_behind_anit()

	# 更新数据
	data.turn_behind_anit()
	
func turn_transverse_clockwise():
	# 沿着底部横向中间线做旋转
	turn_front_anit()
	turn_behind_clockwise()
	
func turn_transverse_anit():
	# 沿着底部横向中间线做旋转
	turn_front_clockwise()
	turn_behind_anit()
	
func turn_longitudinal_clockwise():
	# 沿着底部纵向中间线做旋转
	turn_right_anit()
	turn_left_clockwise()
	
func turn_longitudinal_anit():
	# 沿着底部纵向中间线做旋转
	turn_right_clockwise()
	turn_left_anit()

func turn_center_clockwise():
	# 沿着非底部做旋转
	turn_down_anit()
	turn_up_clockwise()
	
func turn_center_anit():
	# 沿着非底部做旋转
	turn_down_clockwise()
	turn_up_anit()

func box_panel_entered(panel_name):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		select.append(panel_name)
	pass

func box_panel_exited(panel_name):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and select.empty():
		select.append(panel_name)
	pass

func _input(event):
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
		_:
			select.clear()
			return 
	# 做动作
	if action:
		call(action)
	# 清空当前选择项目
	select.clear()
	pass
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
			action_name = "turn_left_clockwise"
		[data.up,"cx_up"]:
			action_name = "turn_left_anit"
		[data.up,"cy_down"]:
			action_name = "turn_longitudinal_anit"
		[data.up,"cy_up"]:
			action_name = "turn_longitudinal_clockwise"
		[data.up,"cz_down"]:
			action_name = "turn_right_anit"
		[data.up,"cz_up"]:
			action_name = "turn_right_clockwise"
			
		[data.up,"ri_right"]:
			action_name = "turn_behind_anit"
		[data.up,"ri_left"]:
			action_name = "turn_behind_clockwise"
		[data.up,"rj_right"]:
			action_name = "turn_transverse_clockwise"
		[data.up,"rj_left"]:
			action_name = "turn_transverse_anit"
		[data.up,"rk_right"]:
			action_name = "turn_front_clockwise"
		[data.up,"rk_left"]:
			action_name = "turn_front_anit"	
			
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
