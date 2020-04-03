extends Spatial
var box = preload("res://scene/Game/TicTacToe_MagicCube/Box.tscn")
var data

func _ready():
	init_data()
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
	centerbox.translation=Vector3(0,-2,0)
	
	centerbox = box.instance()
	centerbox_data = data.left.get_center()
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,0,0)
	
	centerbox = box.instance()
	centerbox_data = data.right.get_center()
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,0,0)
	
	centerbox = box.instance()
	centerbox_data = data.up.get_center()
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,2,0)
	
	centerbox = box.instance()
	centerbox_data = data.front.get_center()
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,0,2)
	
	centerbox = box.instance()
	centerbox_data = data.behind.get_center()
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,0,-2)
	
func _create_side():
	var centerbox = box.instance()
	var centerbox_data = data.down.cx.y
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.z.y
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,-2,0)
	
	centerbox = box.instance()
	centerbox_data = data.down.cz.y
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cx.y
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,-2,0)
	
	centerbox = box.instance()
	centerbox_data = data.down.cy.z
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cy.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,-2,2)
	
	centerbox = box.instance()
	centerbox_data = data.down.cy.x
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cy.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,-2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.cx.y
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cz.y
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,2,0)
	
	centerbox = box.instance()
	centerbox_data = data.up.cz.y
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cx.y
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,2,0)
	
	centerbox = box.instance()
	centerbox_data = data.up.cy.x
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cy.x
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.cy.z
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cy.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(0,2,2)
	
	centerbox = box.instance()
	centerbox_data = data.front.cx.y
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cy.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,0,2)
	
	centerbox = box.instance()
	centerbox_data = data.front.cz.y
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cy.z
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,0,2)

	centerbox = box.instance()
	centerbox_data = data.behind.cx.y
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cy.x
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,0,-2)
	
	centerbox = box.instance()
	centerbox_data = data.behind.cz.y
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cy.x
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,0,-2)
	
func _create_conrner():
	var centerbox = box.instance()
	var centerbox_data = data.down.cx.x
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cz.x
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cx.z
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,-2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.down.cz.x
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cx.x
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cz.z
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,-2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.down.cx.z
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cz.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cx.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,-2,2)
	
	centerbox = box.instance()
	centerbox_data = data.down.cz.z
	centerbox.get_node("DownPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cx.z
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cz.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,-2,2)
	

	centerbox = box.instance()
	centerbox_data = data.up.cz.x
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cx.x
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cx.x
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.cx.x
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cz.x
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.behind.cz.x
	centerbox.get_node("BehindPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,2,-2)
	
	centerbox = box.instance()
	centerbox_data = data.up.cx.z
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.right.cz.z
	centerbox.get_node("RightPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cz.x
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(2,2,2)
	
	centerbox = box.instance()
	centerbox_data = data.up.cz.z
	centerbox.get_node("UpPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.left.cz.z
	centerbox.get_node("LeftPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	centerbox_data = data.front.cx.z
	centerbox.get_node("FrontPanel").name="%s_%s_%s"%[centerbox_data.type, centerbox_data.number,centerbox_data.index]
	add_child(centerbox)
	centerbox.translation=Vector3(-2,2,2)
