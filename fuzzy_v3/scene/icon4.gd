extends TextureRect



func _process(delta):
	var mouse = get_local_mouse_position()
	var size = texture.get_size()
	mouse.x /= size.x
	mouse.y /= size.y
	get_material().set_shader_param("mouse_position", mouse)
