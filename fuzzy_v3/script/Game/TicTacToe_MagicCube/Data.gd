class_name MagicCubeData

extends Node

enum GridType {
	CENTER,
	SIDE,
	CORNER,
}

class MagicGrid:
	var type
	var number
	var index
	func _init(init_type,init_number,init_index):
		type = init_type
		number = init_number
		index = init_index

	func equal_string(string):
		var args = string.split("_")
		return int(args[0])==type and int(args[1])==number and int(args[2])==index
	
	func _to_string():
		return String(type)+"_"+String(number)+"_"+String(index)
	
class Vector3Grid:
	var x
	var y
	var z

	var xyz setget ,get_xyz
	var zyx setget ,get_zyx
	func _init(init_x,init_y,init_z):
		x=init_x
		y=init_y
		z=init_z

	func get_xyz():
		return Vector3Grid.new(x,y,z)
	func get_zyx():
		return Vector3Grid.new(z,y,x)

	func equal_string_array(string_array):
		return (x.equal_string(string_array[0]) and y.equal_string(string_array[1]) and z.equal_string(string_array[2]))


class MagicPanel:
	var grid_table
	var cx setget set_cx,get_cx#第一列
	var cy setget set_cy,get_cy#第二列
	var cz setget set_cz,get_cz#第三列
	var ri setget set_ri,get_ri#第一行
	var rj setget set_rj,get_rj#第二行
	var rk setget set_rk,get_rk#第三行

	var start = 0
	var current = 0
	var end = 9
	var increment = 1

	func should_continue():
		return (current < end)

	func _iter_init(arg):
		current = start
		return should_continue()

	func _iter_next(arg):
		current += increment
		return should_continue()

	func _iter_get(arg):
		return grid_table[floor(current/3)][current%3]

	func _init(init_grid_table):
		grid_table = init_grid_table

	func set_cx(data):
		grid_table[0][0]=data.x
		grid_table[1][0]=data.y
		grid_table[2][0]=data.z

	func get_cx():
		return Vector3Grid.new(grid_table[0][0],grid_table[1][0],grid_table[2][0])

	func set_cy(data):
		grid_table[0][1]=data.x
		grid_table[1][1]=data.y
		grid_table[2][1]=data.z

	func get_cy():
		return Vector3Grid.new(grid_table[0][1],grid_table[1][1],grid_table[2][1])

	func set_cz(data):
		grid_table[0][2]=data.x
		grid_table[1][2]=data.y
		grid_table[2][2]=data.z

	func get_cz():
		return Vector3Grid.new(grid_table[0][2],grid_table[1][2],grid_table[2][2])

	func set_ri(data):
		grid_table[0][0]=data.x
		grid_table[0][1]=data.y
		grid_table[0][2]=data.z

	func get_ri():
		return Vector3Grid.new(grid_table[0][0],grid_table[0][1],grid_table[0][2])

	func set_rj(data):
		grid_table[1][0]=data.x
		grid_table[1][1]=data.y
		grid_table[1][2]=data.z

	func get_rj():
		return Vector3Grid.new(grid_table[1][0],grid_table[1][1],grid_table[1][2])

	func set_rk(data):
		grid_table[2][0]=data.x
		grid_table[2][1]=data.y
		grid_table[2][2]=data.z

	func get_rk():
		return Vector3Grid.new(grid_table[2][0],grid_table[2][1],grid_table[2][2])

	func get_grid(column,row):
		return grid_table[row][column]

	func set_grid(column,row,value):
		grid_table[row][column]=value

	func get_by_clock(number):
		if number<3:
			return get_grid(number,0)
		elif number==3:
			return get_grid(2,1)
		elif number>3 and number<7:
			return get_grid(6-number,2)
		elif number ==7:
			return get_grid(0,1)

	func set_by_clock(number,value):
		if number<3:
			return set_grid(number,0,value)
		elif number==3:
			return set_grid(2,1,value)
		elif number>3 and number<7:
			return set_grid(6-number,2,value)
		elif number ==7:
			return set_grid(0,1,value)

	func turn_anit():
		var last = get_by_clock(7)
		var last_second = get_by_clock(6)

		for i in range(7,1,-1):
			set_by_clock(i,get_by_clock(i-2))

		set_by_clock(1,last)
		set_by_clock(0,last_second)

	func turn_clockwise():
		var last = get_by_clock(0)
		var last_second = get_by_clock(1)

		for i in range(0,6,1):
			set_by_clock(i,get_by_clock(i+2))

		set_by_clock(6,last)
		set_by_clock(7,last_second)

	func get_grid_by_type_number(type,number):
		for i in range(3):
			for j in range(3):
				var grid = grid_table[i][j]
				if grid.type==type and grid.number == number:
					return grid
		return null

	func get_grid_by_name(string):
		var args = string.split("_")
		return get_grid_by_type_number(int(args[0]),int(args[1]))


	func get_center():
		return grid_table[1][1]

	func have(type,number,index):
		for i in range(3):
			for j in range(3):
				var grid = grid_table[i][j]
				if grid.type==int(type) and grid.number == int(number) and grid.index == int(index):
					return true
		return false

	func equal_panel_anit(array):
		var begin_i=-1
		for i in range(8):
			if get_by_clock(i).equal_string(array[0]):
				begin_i = i
				break
		if begin_i<0:
			return false
		var found = true
		for i in range(8):
			var j = (i+begin_i)%8
			if not get_by_clock(j).equal_string(array[i]):
				found = false
				break
		return found

	func equal_panel_clockwise(array):
		var begin_i=-1
		for i in range(8):
			if get_by_clock(i).equal_string(array[7]):
				begin_i = i
				break
		if begin_i<0:
			return false
		var found = true
		for i in range(8):
			var j = (begin_i+i)%8
			if not get_by_clock(j).equal_string(array[(7-i)%8]):
				found = false
				break
		return found



class MagicCube:
	var up
	var left
	var down
	var right
	var front
	var behind
	
	var grid_map = Dictionary()
	
	func _init():
		up = MagicPanel.new([
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,0,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,0,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,1,0)],
			[MagicGrid.new(MagicCubeConstant.GridType.SIDE,4,0),MagicGrid.new(MagicCubeConstant.GridType.CENTER,0,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,5,0)],
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,4,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,8,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,5,0)],
			])

		left = MagicPanel.new([
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,1,2),MagicGrid.new(MagicCubeConstant.GridType.SIDE,1,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,2,2)],
			[MagicGrid.new(MagicCubeConstant.GridType.SIDE,5,1),MagicGrid.new(MagicCubeConstant.GridType.CENTER,1,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,6,1)],
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,5,2),MagicGrid.new(MagicCubeConstant.GridType.SIDE,9,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,6,2)],
			])
		down = MagicPanel.new([
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,2,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,2,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,3,0)],
			[MagicGrid.new(MagicCubeConstant.GridType.SIDE,6,0),MagicGrid.new(MagicCubeConstant.GridType.CENTER,2,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,7,0)],
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,6,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,10,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,7,0)],
			])
		right = MagicPanel.new([
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,3,2),MagicGrid.new(MagicCubeConstant.GridType.SIDE,3,0),MagicGrid.new(MagicCubeConstant.GridType.CORNER,0,2)],
			[MagicGrid.new(MagicCubeConstant.GridType.SIDE,7,1),MagicGrid.new(MagicCubeConstant.GridType.CENTER,3,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,4,1)],
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,7,2),MagicGrid.new(MagicCubeConstant.GridType.SIDE,11,1),MagicGrid.new(MagicCubeConstant.GridType.CORNER,4,2)],
			])
		front = MagicPanel.new([
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,6,1),MagicGrid.new(MagicCubeConstant.GridType.SIDE,10,1),MagicGrid.new(MagicCubeConstant.GridType.CORNER,7,1)],
			[MagicGrid.new(MagicCubeConstant.GridType.SIDE,9,1),MagicGrid.new(MagicCubeConstant.GridType.CENTER,5,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,11,0)],
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,5,1),MagicGrid.new(MagicCubeConstant.GridType.SIDE,8,1),MagicGrid.new(MagicCubeConstant.GridType.CORNER,4,1)],
			])
		behind = MagicPanel.new([
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,1,1),MagicGrid.new(MagicCubeConstant.GridType.SIDE,0,1),MagicGrid.new(MagicCubeConstant.GridType.CORNER,0,1)],
			[MagicGrid.new(MagicCubeConstant.GridType.SIDE,1,1),MagicGrid.new(MagicCubeConstant.GridType.CENTER,4,0),MagicGrid.new(MagicCubeConstant.GridType.SIDE,3,1)],
			[MagicGrid.new(MagicCubeConstant.GridType.CORNER,2,1),MagicGrid.new(MagicCubeConstant.GridType.SIDE,2,1),MagicGrid.new(MagicCubeConstant.GridType.CORNER,3,1)],
			])


	func turn_right_clockwise():
		var first_z=down.cz
		down.cz=behind.cz
		behind.cz=up.cx.zyx
		up.cx=front.cz.zyx
		front.cz=first_z

		right.turn_clockwise()

	func turn_right_anit():
		var first_z=down.cz
		down.cz=front.cz
		front.cz=up.cx.zyx
		up.cx=behind.cz.zyx
		behind.cz=first_z

		right.turn_anit()

	func turn_left_clockwise():
		var first_x=down.cx
		down.cx=front.cx
		front.cx=up.cz.zyx
		up.cz=behind.cx.zyx
		behind.cx=first_x

		left.turn_clockwise()

	func turn_left_anit():
		var first_x=down.cx
		down.cx=behind.cx
		behind.cx=up.cz.zyx
		up.cz=front.cx.zyx
		front.cx=first_x

		left.turn_anit()

	func turn_up_clockwise():
		var first_k=front.rk
		front.rk=right.cz.zyx
		right.cz=behind.ri
		behind.ri=left.cx.zyx
		left.cx=first_k
		up.turn_clockwise()

	func turn_up_anit():
		var first_k=front.rk
		front.rk=left.cx
		left.cx = behind.ri.zyx
		behind.ri=right.cz
		right.cz=first_k.zyx
		up.turn_anit()

	func turn_down_clockwise():
		var first_i=front.ri
		front.ri=left.cz
		left.cz=behind.rk.zyx
		behind.rk=right.cx
		right.cx=first_i.zyx
		down.turn_clockwise()

	func turn_down_anit():
		var first_i=front.ri
		front.ri=right.cx.zyx
		right.cx=behind.rk
		behind.rk=left.cz.zyx
		left.cz=first_i
		down.turn_anit()

	func turn_front_clockwise():
		var first_k=down.rk
		down.rk=right.rk
		right.rk=up.rk
		up.rk=left.rk
		left.rk=first_k
		front.turn_clockwise()

	func turn_front_anit():
		var first_k=down.rk
		down.rk=left.rk
		left.rk=up.rk
		up.rk=right.rk
		right.rk=first_k
		front.turn_anit()

	func turn_behind_clockwise():
		var first_i=down.ri
		down.ri=left.ri
		left.ri=up.ri
		up.ri=right.ri
		right.ri=first_i
		behind.turn_clockwise()

	func turn_behind_anit():
		var first_i=down.ri
		down.ri=right.ri
		right.ri=up.ri
		up.ri=left.ri
		left.ri=first_i
		behind.turn_anit()

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

	func get_in_panel(grid_array):
		for one_panel in [up,left,down,right,front,behind]:
			var in_panel=true
			for grid in grid_array:
				var args = grid.split("_")
				if not one_panel.have(args[0],args[1],args[2]):
					in_panel=false
			if in_panel:
				return one_panel
		return false
