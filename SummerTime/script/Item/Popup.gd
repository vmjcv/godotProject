extends Popup


onready var _big = get_node("BigPanel")
onready var _small = get_node("SmallPanel")
onready var _big_label = get_node("BigPanel/Label")
onready var _big_texture = get_node("BigPanel/TextureRect")
onready var _small_label = get_node("SmallPanel/Label")

func _ready():
	_init_signal()

func _init_signal():
	ItemMainPanel.connect("close_item_info", self, "_close")
	ItemMainPanel.connect("show_item_info", self, "_update_info")

func _update_info(label_text,texture_path,is_key):
	_big.visible=false
	_small.visible=false
	if is_key:
		_big.visible=true
		_big_label.text = label_text
		_big_texture.texture = load(texture_path)
	else:
		_small.visible=true
		_small_label.text = label_text
	popup()
	
func _close():
	visible=false

