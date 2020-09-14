tool
extends ColorRect

var radius= 0

signal shape_mouse_entered
signal shape_mouse_exited

var exited_color = Color.blue
var entered_color = Color.red


func _init():
	color = exited_color
	material = material.duplicate()
	material.set_shader_param("color",color)
	pass

func draw(radius):
	rect_size=Vector2(2*radius,2*radius)
	$area2d/shape.shape.radius = radius
	$area2d/shape.position = Vector2(radius,radius)
	var pos = self.get_position()
	self.radius = radius
	set_position(pos)

func set_position(position,default = false):
	rect_position = position +Vector2(-self.radius,-self.radius)

func get_position():
	return rect_position - Vector2(-radius,-radius)


func _on_area2d_mouse_entered():
	color = entered_color
	material.set_shader_param("color",color)
	emit_signal("shape_mouse_entered",self)
	print("111111111111111111")

func _on_area2d_mouse_exited():
	color = exited_color
	material.set_shader_param("color",color)
	emit_signal("shape_mouse_exited",self)
	print("2222222222222222")
