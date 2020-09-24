extends TextEdit

export(float) var line_min_y = 28

func _ready():
	emit_signal("text_changed")

func _on_text_changed():
	rect_size.y =  get_total_visible_rows()*line_min_y
