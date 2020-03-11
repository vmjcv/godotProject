extends TextureRect

var item_panel

func _ready():
	call_deferred("_move_HUD_scene")

func _move_HUD_scene():
	_remove_from_panrent()
	add_child(item_panel)
	move_child(item_panel,0)
	
func _remove_from_panrent():
	item_panel = ItemMainPanel
	item_panel.get_parent().remove_child(item_panel)
