extends Line2D

enum line_type {DOTTED,SOLID}
var dotted_texture = preload("res://dotted_line.png")
var solid_texture = preload("res://solid_line.png")

func _ready():
	add_point(Vector2(100,0))
	add_point(Vector2(400,800))
	
	draw(line_type.DOTTED,Color(0.3,0.2,0.5,1))
	pass

func _draw():
	
	pass

func clear():
	points.resize(0)

func _process(delta):
	update()

func draw(type,color):
	match line_type:
		line_type.DOTTED:
			texture = dotted_texture
		line_type.SOLID:
			texture = solid_texture
	
	material.set_shader_param("color",color)
