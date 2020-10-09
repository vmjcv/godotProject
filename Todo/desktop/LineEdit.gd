extends TextEdit

export(float) var line_min_y = 28

onready var top = $"HBoxContainer/top"
onready var finish = $"HBoxContainer/finish"
onready var close = $"HBoxContainer/close"
var task

func _ready():
	change_y()
	hide_tool_button()
	

func _on_text_changed():
	change_y()
	
func _on_text_line_mouse_entered():
	show_tool_button()


func _on_text_line_mouse_exited():
	hide_tool_button()


func show_tool_button():
	top.show()
	finish.show()
	close.show()

func hide_tool_button():
	top.hide()
	finish.hide()
	close.hide()


func change_y():
	var text_y = get_total_visible_rows()*line_min_y
	rect_min_size.y =  text_y

