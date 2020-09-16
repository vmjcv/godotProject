extends CheckButton

var draw_color ={
	DRAW_NORMAL:Color(1,1,1,0.7),
	DRAW_PRESSED:Color(0.4, 0.6, 1, 0.7),
	DRAW_HOVER:Color(1,1,1,0.5),
	DRAW_DISABLED:Color(1,1,1,0.1),
	DRAW_HOVER_PRESSED:Color(0.4, 0.6, 1, 0.7),
}

func _ready():
	pass


func _on_pan_draw():
	print(get_draw_mode())
	var draw_mode = get_draw_mode()
	modulate = draw_color[draw_mode]
	
