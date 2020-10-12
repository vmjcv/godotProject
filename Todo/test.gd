extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var s = "### aaa ## sdafsdf"
	s = translate_headline(s)
	print(s)
	pass # Replace with function body.


func translate_headline(s):
	var regex = RegEx.new()
	var compile_str = ""
	var font_str = ""
	for i in range(1,6):
		compile_str = "^" + "#".repeat(i) + "\\s+(.*?)$"
		regex.clear()
		regex.compile(compile_str)
		font_str = "[font=res/" + str(32 - (i)*4) + "px.tres]$1[/font]"
		s = regex.sub(s,font_str,true)
		print(s)
	return s
