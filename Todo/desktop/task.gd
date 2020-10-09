extends PanelContainer

onready var line_edit = $text_line
onready var top_button = $text_line/HBoxContainer/top
onready var finish_button = $text_line/HBoxContainer/finish
onready var close_button = $text_line/HBoxContainer/close

signal top
signal finish
signal close



func _ready():
	init_signal()
	

func init_signal():
	line_edit.connect("minimum_size_changed",self,"y_change")

func y_change():
	rect_min_size.y = line_edit.rect_min_size.y

func _on_top_pressed():
	emit_signal("top")

func _on_finish_pressed():
	emit_signal("finish")

func _on_close_pressed():
	emit_signal("close")
