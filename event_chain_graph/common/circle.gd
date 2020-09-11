extends ColorRect

var radius

signal shape_mouse_entered
signal shape_mouse_exited

func _ready():
	draw(50)
	rect_position = Vector2(100,100)


func draw(radius):
	rect_size=Vector2(2*radius,2*radius)
	$area2d/shape.shape.radius = radius
	$area2d/shape.position = Vector2(radius,radius)
	rect_position = Vector2(-radius,-radius)
	self.radius = radius

func set_position(position,default = false):
	rect_position = position +Vector2(-radius,-radius)

func get_position():
	return rect_position -Vector2(-radius,-radius)


func _on_area2d_mouse_entered():
	print("kkkkk")
	emit_signal("shape_mouse_entered",self)

func _on_area2d_mouse_exited():
	print("kkkkk22222222")
	emit_signal("shape_mouse_exited",self)
