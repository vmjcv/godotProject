class_name MagicCubeData

extends Node

enum GridType {
	CENTER,
	SIDE,
	CORNER,
}

class MagicGrid:
	func _init(type,number,index):
		self.type = type
		self.number = number
		self.index = index
		
class MagicPanel:
	var grid_table
	var x setget set_x,get_x#第一列
	var y setget set_y,get_y#第二列
	var z setget set_z,get_z#第三列
	var i setget set_i,get_i#第一行
	var j setget set_j,get_j#第二行
	var k setget set_k,get_k#第三行
	func _init(init_grid_table):
		grid_table = init_grid_table
	
	func set_x(data:Vector3):
		grid_table[0][0]=data.x
		grid_table[1][0]=data.y
		grid_table[2][0]=data.z
	
	func get_x():
		return Vector3(grid_table[0][0],grid_table[1][0],grid_table[2][0])

	func set_y(data:Vector3):
		grid_table[0][1]=data.x
		grid_table[1][1]=data.y
		grid_table[2][1]=data.z
	
	func get_y():
		return Vector3(grid_table[0][1],grid_table[1][1],grid_table[2][1])
		
	func set_z(data:Vector3):
		grid_table[0][2]=data.x
		grid_table[1][2]=data.y
		grid_table[2][2]=data.z
	
	func get_z():
		return Vector3(grid_table[0][2],grid_table[1][2],grid_table[2][2])
		
	func set_i(data:Vector3):
		grid_table[0][0]=data.x
		grid_table[0][1]=data.y
		grid_table[0][2]=data.z
	
	func get_i():
		return Vector3(grid_table[0][0],grid_table[0][1],grid_table[0][2])

	func set_j(data:Vector3):
		grid_table[1][0]=data.x
		grid_table[1][1]=data.y
		grid_table[1][2]=data.z
	
	func get_j():
		return Vector3(grid_table[1][0],grid_table[1][1],grid_table[1][2])
		
	func set_k(data:Vector3):
		grid_table[2][0]=data.x
		grid_table[2][1]=data.y
		grid_table[2][2]=data.z
	
	func get_k():
		return Vector3(grid_table[2][0],grid_table[2][1],grid_table[2][2])
	
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
	
	func turn_clockwise():
		var last = get_by_clock(7)
		var last_second = get_by_clock(6)
		
		for i in range(7,1,-1):
			set_by_clock(i,get_by_clock(i-2))
		
		set_by_clock(1,last)
		set_by_clock(0,last_second)

	func turn_anit():
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
					return [i,j]
		return null
	
	func get_center():
		return grid_table[1][1]

class Cube:
	var up
	var left
	var down
	var right
	var front
	var behind
	func _init():
		up = MagicPanel.new([
				[MagicGrid.new(GridType.CORNER,0,0),MagicGrid.new(GridType.SIDE,0,0),MagicGrid.new(GridType.CORNER,1,0)],
				[MagicGrid.new(GridType.SIDE,4,0),MagicGrid.new(GridType.CENTER,0,0),MagicGrid.new(GridType.SIDE,5,0)],
				[MagicGrid.new(GridType.CORNER,4,0),MagicGrid.new(GridType.SIDE,8,0),MagicGrid.new(GridType.CORNER,5,0)],
				])
		
		left = MagicPanel.new([
				[MagicGrid.new(GridType.CORNER,1,2),MagicGrid.new(GridType.SIDE,1,0),MagicGrid.new(GridType.CORNER,2,2)],
				[MagicGrid.new(GridType.SIDE,5,1),MagicGrid.new(GridType.CENTER,1,0),MagicGrid.new(GridType.SIDE,6,1)],
				[MagicGrid.new(GridType.CORNER,5,2),MagicGrid.new(GridType.SIDE,9,0),MagicGrid.new(GridType.CORNER,6,2)],
				])
		down = MagicPanel.new([
				[MagicGrid.new(GridType.CORNER,2,0),MagicGrid.new(GridType.SIDE,2,0),MagicGrid.new(GridType.CORNER,3,0)],
				[MagicGrid.new(GridType.SIDE,6,0),MagicGrid.new(GridType.CENTER,2,0),MagicGrid.new(GridType.SIDE,7,0)],
				[MagicGrid.new(GridType.CORNER,6,0),MagicGrid.new(GridType.SIDE,10,0),MagicGrid.new(GridType.CORNER,7,0)],
				])
		right = MagicPanel.new([
				[MagicGrid.new(GridType.CORNER,3,2),MagicGrid.new(GridType.SIDE,3,0),MagicGrid.new(GridType.CORNER,0,2)],
				[MagicGrid.new(GridType.SIDE,7,1),MagicGrid.new(GridType.CENTER,3,0),MagicGrid.new(GridType.SIDE,4,1)],
				[MagicGrid.new(GridType.CORNER,7,2),MagicGrid.new(GridType.SIDE,11,1),MagicGrid.new(GridType.CORNER,4,2)],
				])
		front = MagicPanel.new([
				[MagicGrid.new(GridType.CORNER,6,1),MagicGrid.new(GridType.SIDE,10,1),MagicGrid.new(GridType.CORNER,7,1)],
				[MagicGrid.new(GridType.SIDE,9,1),MagicGrid.new(GridType.CENTER,5,0),MagicGrid.new(GridType.SIDE,11,0)],
				[MagicGrid.new(GridType.CORNER,5,1),MagicGrid.new(GridType.SIDE,8,1),MagicGrid.new(GridType.CORNER,4,1)],
				])
		behind = MagicPanel.new([
				[MagicGrid.new(GridType.CORNER,1,1),MagicGrid.new(GridType.SIDE,0,1),MagicGrid.new(GridType.CORNER,0,1)],
				[MagicGrid.new(GridType.SIDE,1,1),MagicGrid.new(GridType.CENTER,4,0),MagicGrid.new(GridType.SIDE,3,1)],
				[MagicGrid.new(GridType.CORNER,2,1),MagicGrid.new(GridType.SIDE,2,1),MagicGrid.new(GridType.CORNER,3,1)],
				])
				

	func turn_right_clockwise():
		var first_z=down.z
		down.z=behind.z
		behind.z=up.x.zyx
		up.x=front.z.zyx
		front.z=first_z
		
		right.turn_anit()
		
	func turn_right_anit():
		var first_z=down.z
		down.z=front.z
		front.z=up.x.zyx
		up.x=behind.z.zyx
		behind.z=first_z
		
		right.turn_clockwise()
	
	func turn_left_clockwise():
		var first_x=down.x
		down.x=front.x
		front.x=up.z.zyx
		up.z=behind.x.zyx
		behind.x=first_x
		
		left.turn_anit()
		
	func turn_left_anit():
		var first_x=down.x
		down.x=behind.x
		behind.x=up.z.zyx
		up.z=front.x.zyx
		front.x=first_x
		
		left.turn_clockwise()
	
	func turn_up_clockwise():
		var first_k=front.k
		front.k=right.z.zyx
		right.z=behind.i
		behind.i=left.x.zyx
		left.x=first_k
		up.turn_anit()
		
	func turn_up_anit():
		var first_k=front.k
		front.k=left.x
		left.x = behind.i.zyx
		behind.i=right.z
		right.z=first_k.zyx
		up.turn_clockwise()
		
	func turn_down_clockwise():
		var first_i=front.i
		front.i=left.z
		left.z=behind.k.zyx
		behind.k=right.x
		right.x=first_i.zyx
		down.turn_anit()
		
	func turn_down_anit():
		var first_i=front.i
		front.i=right.x.zyx
		right.x=behind.k
		behind.k=left.z.zyx
		left.z=first_i
		down.turn_clockwise()
	
	func turn_front_clockwise():
		var first_k=down.k
		down.k=right.k
		right.k=up.k
		up.k=left.k
		left.k=first_k
		front.turn_anit()
		
	func turn_front_anit():
		var first_k=down.k
		down.k=left.k
		left.k=up.k
		up.k=right.k
		right.k=first_k
		front.turn_clockwise()
		
	func turn_behind_clockwise():
		var first_i=down.i
		down.i=left.i
		left.i=up.i
		up.i=right.i
		right.i=first_i
		behind.turn_anit()
		
	func turn_behind_anit():
		var first_i=down.i
		down.i=right.i
		right.i=up.i
		up.i=left.i
		left.i=first_i
		behind.turn_clockwise()
		
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
	
