extends MarginContainer

var label setget set_label,get_label
var color setget set_bgcolor,get_bgcolor

func _ready():
	pass # Replace with function body.

func set_label(templabel):
	$Bg/Label.text = templabel

func get_label():
	return $Bg/Label.text

func set_bgcolor(tempcolor):
	$Bg.color = tempcolor

func get_bgcolor():
	return $Bg.color
