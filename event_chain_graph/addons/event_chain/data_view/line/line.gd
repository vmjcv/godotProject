tool
extends Line2D

var dotted_texture = preload("res://addons/event_chain/data_view/line/res/dotted_line.png")
var solid_texture = preload("res://addons/event_chain/data_view/line/res/solid_line.png")
var arrow_texture = preload("res://addons/event_chain/data_view/line/res/arrow.png")

var begin_arrow
var end_arrow
var time_label
var info_label
var line_time

var type
var begin_pos
var end_pos
var begin_color
var end_color
var time
var info


func _ready():
	pass


func _draw():
	pass

func _process(delta):
	update()

func clear_arrows():
	if begin_arrow:
		begin_arrow.queue_free()
	if end_arrow:
		end_arrow.queue_free()

func clear_label():
	if time_label:
		time_label.queue_free()
	if info_label:
		info_label.queue_free()

func draw(type,begin_pos,end_pos,begin_color,end_color,time,info):
	self.type = type
	self.begin_pos = begin_pos
	self.end_pos = end_pos
	self.begin_color = begin_color 
	self.end_color = end_color
	self.time = time 
	self.info = info 
	
	clear_points()
	clear_arrows()
	clear_label()
	add_point(begin_pos)
	add_point(end_pos)
	material = ShaderMaterial.new()
	material.shader = load("res://addons/event_chain/data_view/line/res/line.shader")
	var need_begin_arrow =false
	var need_end_arrow =false 
	
	match type:
		LineConstant.line_type.DOTTED:
			texture = dotted_texture
		LineConstant.line_type.SOLID:
			texture = solid_texture
			need_end_arrow = true
	var gradient_data = Gradient.new()
	gradient_data.set_color(0,begin_color)
	gradient_data.set_color(1,end_color)
	var gradient_texture = GradientTexture.new()
	gradient_texture.gradient = gradient_data
	material.set_shader_param("gradient",gradient_texture)
	
	if need_begin_arrow:
		begin_arrow = Sprite.new()
		begin_arrow.texture = arrow_texture.instance()
		add_child(begin_arrow)
		var angle = begin_pos.angle_to_point(end_pos)
		begin_arrow.rotation = angle
		begin_arrow.position = begin_pos
		begin_arrow.material = ShaderMaterial.new() 
		begin_arrow.material.shader = load("res://addons/event_chain/data_view/line/res/arrow.shader")
		begin_arrow.material.set_shader_param("color",begin_color)


	if need_end_arrow:
		end_arrow = Sprite.new()
		end_arrow.texture = arrow_texture
		add_child(end_arrow)
		var angle = end_pos.angle_to_point(begin_pos)
		end_arrow.rotation = angle
		end_arrow.position = end_pos
		end_arrow.material = ShaderMaterial.new() 
		end_arrow.material.shader = load("res://addons/event_chain/data_view/line/res/arrow.shader")
		end_arrow.material.set_shader_param("color",end_color)
	
	if time:
		time_label = Label.new()
		line_time = time
		time_label.text = str(time)
		time_label.align = HALIGN_CENTER
		time_label.valign = VALIGN_CENTER
		add_child(time_label)
		time_label.modulate= Color.blue
		
		var angle = end_pos.angle_to_point(begin_pos)
		time_label.rect_rotation = rad2deg(angle)
		var offset = Vector2.DOWN*10
		offset = offset.rotated(angle)
		time_label.rect_position = (begin_pos+end_pos)/2+offset

		
	
	if info:
		info_label = Label.new()
		info_label.text = str(info)
		info_label.align = HALIGN_CENTER
		info_label.valign = VALIGN_CENTER

		add_child(info_label)
		info_label.modulate= Color.green
		info_label.rect_position = (begin_pos+end_pos)/2
		var angle = end_pos.angle_to_point(begin_pos)
		info_label.rect_rotation = rad2deg(angle)
		
		var offset = Vector2.UP*20
		offset = offset.rotated(angle)
		info_label.rect_position = (begin_pos+end_pos)/2+offset

func change_end_pos(end_pos):
	self.draw(type,begin_pos,end_pos,begin_color,end_color,time,info)
	
func change_pos(begin_pos,end_pos):
	self.draw(type,begin_pos,end_pos,begin_color,end_color,time,info)
