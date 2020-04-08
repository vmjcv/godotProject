extends MeshInstance

var up setget set_up
var left setget set_left
var down setget set_down
var right setget set_right
var front setget set_front
var behind setget set_behind

var cross = preload("res://scene/Game/TicTacToe_MagicCube/Cross.tscn")
var ring = preload("res://scene/Game/TicTacToe_MagicCube/Ring.tscn")
onready var tween = $"Tween"

func _ready():
	pass


func init_signal(manage):
	for node in get_children():
		match node.name:
			'FrontPanel','DownPanel','BehindPanel','LeftPanel','RightPanel','UpPanel':
				pass
			_:
				node.connect("mouse_entered",manage,"box_panel_entered",[node.name])
				node.connect("mouse_exited",manage,"box_panel_exited",[node.name])

func add_panel(toward,data_type):
	var panel
	match data_type:
		MagicCubeConstant.Data.CROSS:
			panel = cross.instance()
		MagicCubeConstant.Data.RING:
			panel = ring.instance()
	match toward:
		MagicCubeConstant.Towards.UP:
			set_up(panel)
		MagicCubeConstant.Towards.LEFT:
			set_left(panel)
		MagicCubeConstant.Towards.DOWN:
			set_down(panel)
		MagicCubeConstant.Towards.RIGHT:
			set_right(panel)
		MagicCubeConstant.Towards.FRONT:
			set_front(panel)
		MagicCubeConstant.Towards.BEHIND:
			set_behind(panel)

func set_up(panel):
	if up:
		remove_child(up)
	up = panel
	up.name="up"
	add_child(up)

func set_left(panel):
	if left:
		remove_child(left)
	left = panel
	left.name="left"
	add_child(left)
	left.rotation_degrees = Vector3(0,0,90)
	
func set_down(panel):
	if down:
		remove_child(down)
	down = panel
	down.name="down"
	add_child(down)
	down.rotation_degrees = Vector3(0,0,180)

func set_right(panel):
	if right:
		remove_child(right)
	right = panel
	right.name="right"
	add_child(right)
	right.rotation_degrees = Vector3(0,0,270)
	
func set_front(panel):
	if front:
		remove_child(front)
	front = panel
	front.name="front"
	add_child(front)
	front.rotation_degrees = Vector3(90,0,0)
	
func set_behind(panel):
	if behind:
		remove_child(behind)
	behind = panel
	behind.name="behind"
	add_child(behind)
	behind.rotation_degrees = Vector3(270,0,0)
	
func turn_right_clockwise():
	transform*=Transform(Basis(Vector3(1,0,0),-TAU/4))
	transform.origin = transform.origin.rotated(Vector3(1,0,0),-TAU/4)
	
func turn_right_anit():
	transform*=Transform(Basis(Vector3(1,0,0),TAU/4))
	transform.origin = transform.origin.rotated(Vector3(1,0,0),TAU/4)

func turn_left_clockwise():
	transform*=Transform(Basis(Vector3(-1,0,0),-TAU/4))
	transform.origin = transform.origin.rotated(Vector3(-1,0,0),-TAU/4)
	
func turn_left_anit():
	transform*=Transform(Basis(Vector3(-1,0,0),TAU/4))
	transform.origin = transform.origin.rotated(Vector3(-1,0,0),TAU/4)

func turn_up_clockwise():
	transform*=Transform(Basis(Vector3(0,1,0),-TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,1,0),-TAU/4)
	
func turn_up_anit():
	transform*=Transform(Basis(Vector3(0,1,0),TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,1,0),TAU/4)
	
func turn_down_clockwise():
	tween.interpolate_property(self, "transform", transform, transform*Transform(Basis(Vector3(0,-1,0),-TAU/4)), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(transform, "origin", transform.origin, transform.origin.rotated(Vector3(0,-1,0),-TAU/4), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	"""
	transform*=Transform(Basis(Vector3(0,-1,0),-TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,-1,0),-TAU/4)
	"""
func turn_down_anit():
	transform*=Transform(Basis(Vector3(0,-1,0),TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,-1,0),TAU/4)

func turn_front_clockwise():
	transform*=Transform(Basis(Vector3(0,0,1),-TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,0,1),-TAU/4)
	
func turn_front_anit():
	transform*=Transform(Basis(Vector3(0,0,1),TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,0,1),TAU/4)
	
func turn_behind_clockwise():
	transform*=Transform(Basis(Vector3(0,0,-1),-TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,0,-1),-TAU/4)
	
func turn_behind_anit():
	transform*=Transform(Basis(Vector3(0,0,-1),TAU/4))
	transform.origin = transform.origin.rotated(Vector3(0,0,-1),TAU/4)
	


