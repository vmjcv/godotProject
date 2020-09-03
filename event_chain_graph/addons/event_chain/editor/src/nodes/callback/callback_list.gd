tool
extends EventChainNode


var _callback_list
var line_edit
var delete_select

func _init() -> void:
	unique_id = "callback_list"
	display_name = "CallbackList"
	category = "Callback"
	description = "创建一个触发函数链表"
	
	set_output(0, "List", EventChainGraphDataType.LIST)

func _ready() -> void:
	connect("input_changed", self, "_on_input_changed")


func _generate_outputs() -> void:
	_callback_list = []
	for i in range(get_inputs_count()):
		_callback_list.append(get_input_single(i, null))
	output[0] = _callback_list


func _on_input_changed(slot: int, _value) -> void:
	_generate_outputs()


func _on_default_gui_ready() -> void:

	var center_box = HBoxContainer.new()
	center_box.name = "Center"
	center_box.size_flags_horizontal = SIZE_EXPAND_FILL
	
	var line_edit = LineEdit.new()
	line_edit.name = "LineEdit"
	line_edit.placeholder_text = "回调概述"
	line_edit.expand_to_text_length =true
	self.line_edit=line_edit
	center_box.add_child(line_edit)

	var button_add := Button.new()
	button_add.text = "增加回调"
	button_add.rect_min_size = Vector2(175, 0)
	center_box.add_child(button_add)
	button_add.connect("pressed", self, "_on_button_add_pressed")

	add_child(center_box)

	var delete_box = HBoxContainer.new()
	delete_box.name = "Delete"
	delete_box.size_flags_horizontal = SIZE_EXPAND_FILL
	
	var delete_dropdown = OptionButton.new()
	delete_dropdown.name = "OptionButton"
	
	var delete_items = {}
	for i in range(get_inputs_count()):
		delete_items[String(i)]=i

	for item in delete_items.keys():
		delete_dropdown.add_item(item)
	delete_box.add_child(delete_dropdown)
	self.delete_select=delete_dropdown

	var button_delete := Button.new()
	button_delete.text = "删除键值"
	button_delete.rect_min_size = Vector2(175, 0)
	delete_box.add_child(button_delete)
	button_delete.connect("pressed", self, "_on_button_delete_pressed")

	add_child(delete_box)

func _on_button_add_pressed() -> void:
	var count= get_inputs_count()
	set_input(count, "", EventChainGraphDataType.CALLBACK)
	._generate_default_gui()
	.regenerate_default_ui()


func reset_input() -> void:
	var j=0
	for i in range(get_inputs_count()):
		if not _inputs.has(j):
			j=j+1
		_inputs[i]=_inputs[j]
		
		if i!=j:
			_inputs.erase(j)
		if i>=2:
			_outputs[i]=_outputs[j]
			if i!=j:
				_outputs.erase(j)
		j=j+1
	

func _on_button_delete_pressed() -> void:
	remove_input(self.delete_select.get_selected()+2)
	reset_input()
	#_setup_slots()
	._generate_default_gui()
	.regenerate_default_ui()



