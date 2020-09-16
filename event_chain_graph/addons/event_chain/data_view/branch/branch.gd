tool
extends Polygon2D
var info_label

var type
var begin_pos
var end_pos
var rect_color
var info

signal mouse_entered
signal mouse_exited


var left_circle
var right_circle

var circle_tscn = preload("res://addons/event_chain/data_view/common/circle.tscn")

func _ready():
	pass

func _draw():
	pass

func _process(delta):
	update()

func clear_label():
	if info_label:
		info_label.queue_free()

func clear_circle():
	if left_circle:
		left_circle.queue_free()
	if right_circle:
		right_circle.queue_free()	

func draw(type,begin_pos,end_pos,rect_color,info):
	var min_x = min(begin_pos.x,end_pos.x)
	var min_y = min(begin_pos.y,end_pos.y)
	var max_x = max(begin_pos.x,end_pos.x)
	var max_y = max(begin_pos.y,end_pos.y)
	
	begin_pos = Vector2(min_x,min_y)
	end_pos = Vector2(max_x,max_y)
	
	self.type = type
	self.begin_pos = begin_pos
	self.end_pos = end_pos
	self.rect_color = rect_color
	self.info = info
	clear_label()
	clear_circle()
	polygon.resize(0)
	polygon = PoolVector2Array([
	Vector2(((end_pos-begin_pos)/2).x+begin_pos.x,begin_pos.y),
	Vector2(end_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y),
	Vector2(((end_pos-begin_pos)/2).x+begin_pos.x,end_pos.y),
	Vector2(begin_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y)
	])
	
	$area2d/collision.polygon.resize(0)
	$area2d/collision.polygon = PoolVector2Array([
	Vector2(((end_pos-begin_pos)/2).x+begin_pos.x,begin_pos.y),
	Vector2(end_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y),
	Vector2(((end_pos-begin_pos)/2).x+begin_pos.x,end_pos.y),
	Vector2(begin_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y)
	])
	
	color = rect_color

	if info:
		info_label = Label.new()
		info_label.text = str(info)
		info_label.align = HALIGN_CENTER
		info_label.valign = VALIGN_CENTER
		add_child(info_label)
		info_label.modulate= Color.darkgray
		info_label.rect_position = (begin_pos+end_pos)/2-info_label.rect_size/2
	

	
	match type:
		BranchConstant.branch_type.IF:
			left_circle = create_circle(Vector2(begin_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y))
			right_circle = create_circle(Vector2(end_pos.x,((end_pos-begin_pos)/2).y+begin_pos.y))
			pass
		BranchConstant.branch_type.MATCH:
			pass

func create_circle(pos):
	var circle = circle_tscn.instance()
	add_child(circle)
	circle.draw(10)
	circle.set_position(pos)
	return circle


func change_pos(begin_pos,end_pos):
	self.draw(type,begin_pos,end_pos,rect_color,info)

func _on_area2d_mouse_entered():
	emit_signal("mouse_entered",self)

func _on_area2d_mouse_exited():
	emit_signal("mouse_exited",self)

func get_intersects_pos(begin_pos,end_pos):
	var first_pos = begin_pos
	var second_pos = end_pos
	if Geometry.is_point_in_polygon(begin_pos,$area2d/collision.polygon):
		first_pos = begin_pos
		second_pos = end_pos
		pass
	elif Geometry.is_point_in_polygon(end_pos,$area2d/collision.polygon):
		first_pos = end_pos
		second_pos = begin_pos
	
	var intersects
	for i in range(4):
		intersects = Geometry.segment_intersects_segment_2d($area2d/collision.polygon[i],$area2d/collision.polygon[(i+1)%4],first_pos,second_pos)
		if intersects:
			break
	first_pos = intersects
	return first_pos


func _on_area2d_input_event(viewport, event, shape_idx):
	print(viewport, event, shape_idx)
	pass # Replace with function body.
