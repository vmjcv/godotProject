extends Spatial
var box = preload("res://scene/Game/TicTacToe_MagicCube/Box.tscn")
var data

func _ready():
	pass

func init_data():
	data = MagicCubeData.Cube.new()
	_create_center()
	_create_side()
	_create_conrner()

func _create_center():
	var centerbox = box.instance()
	var centerbox_data = data.down.get_center()
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,-2,0)
	
	centerbox = box.instance()
	centerbox_data = data.left.get_center()
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,0,0)
	
	centerbox = box.instance()
	centerbox_data = data.right.get_center()
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,0,0)
	
	centerbox = box.instance()
	centerbox_data = data.up.get_center()
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,2,0)
	
	centerbox = box.instance()
	centerbox_data = data.front.get_center()
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,0,2)
	
	centerbox = box.instance()
	centerbox_data = data.behind.get_center()
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,0,-2)
	
func _create_side():
	var centerbox = box.instance()
	var centerbox_data = data.down.x.y
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.z.y
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,-2,0)
	
	centerbox = box.instance()
	centerbox_data = data.down.z.y
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.x.y
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,-2,0)
	
	centerbox = box.instance()
	centerbox_data = data.down.y.z
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.front.y.x
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,-2,2)
	
	centerbox = box.instance()
	centerbox_data = data.down.y.x
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.behind.y.z
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,-2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.x.y
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.z.y
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,2,0)
	
	centerbox = box.instance()
	centerbox_data = data.up.z.y
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.x.y
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,2,0)
	
	centerbox = box.instance()
	centerbox_data = data.up.y.x
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.behind.y.x
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.y.z
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.front.y.z
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(0,2,2)
	
	centerbox = box.instance()
	centerbox_data = data.front.x.y
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.y.z
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,0,2)
	
	centerbox = box.instance()
	centerbox_data = data.front.z.y
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.y.z
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,0,2)

	centerbox = box.instance()
	centerbox_data = data.behind.x.y
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.y.x
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,0,-2)
	
	centerbox = box.instance()
	centerbox_data = data.behind.z.y
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.y.x
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,0,-2)
	
func _create_conrner():
	var centerbox = box.instance()
	var centerbox_data = data.down.x.x
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.z.x
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.behind.x.z
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,-2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.down.z.x
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.x.x
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.behind.z.z
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,-2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.down.x.z
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.z.z
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.front.x.x
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,-2,2)
	
	centerbox = box.instance()
	centerbox_data = data.down.z.z
	centerbox.DownPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.x.z
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.front.z.x
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,-2,2)
	

	centerbox = box.instance()
	centerbox_data = data.up.z.x
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.x.x
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.behind.x.x
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.x.x
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.z.x
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.behind.z.x
	centerbox.BehindPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.x.z
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.right.z.z
	centerbox.RightPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.front.z.x
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(2,2,2)
	
	centerbox = box.instance()
	centerbox_data = data.up.z.z
	centerbox.UpPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.left.z.z
	centerbox.LeftPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	centerbox_data = data.front.x.z
	centerbox.FrontPanel.name=centerbox_data.type+centerbox_data.number+centerbox_data.index
	add_child(centerbox)
	centerbox.translation=Vector3(-2,2,2)
