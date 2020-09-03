tool
extends ProgressBar


export var decrease_button: NodePath
export var increase_button: NodePath
export var name_label: NodePath
export var value_edit: NodePath
export(int, "Top", "Middle", "Bottom", "Single") var style = 3 setget set_style

var undo_redo: UndoRedo

var _increase_btn: Button
var _decrease_btn: Button
var _name_label: Label
var _line_edit: LineEdit

var _bg = preload("styles/progress_bar_bg.tres")
var _bg_top = preload("styles/progress_bar_bg_top.tres")
var _bg_middle = preload("styles/progress_bar_bg_middle.tres")
var _bg_bottom = preload("styles/progress_bar_bg_bottom.tres")
var _fg = preload("styles/progress_bar_fg.tres")
var _fg_top = preload("styles/progress_bar_fg_top.tres")
var _fg_middle = preload("styles/progress_bar_fg_middle.tres")
var _fg_bottom = preload("styles/progress_bar_fg_bottom.tres")

var _name
var _clicked := false
var _acc := 0.0
var _previous_value := 0.0


func _ready() -> void:
	undo_redo = get_tree().root.get_node("EventChainGraphEditorPluginProxy").proxy.get_undo_redo()
	_increase_btn = get_node(increase_button)
	_decrease_btn = get_node(decrease_button)
	_name_label = get_node(name_label)
	_line_edit = get_node(value_edit)

	_increase_btn.connect("pressed", self, "_on_button_pressed", [true])
	_decrease_btn.connect("pressed", self, "_on_button_pressed", [false])
	connect("value_changed", self, "_update_line_edit_value")
	_line_edit.connect("text_entered", self, "_on_line_edit_changed")
	_line_edit.connect("focus_exited", self, "_on_line_edit_changed")

	set_label_value(_name)
	_update_line_edit_value(value)
	_update_style()


func get_line_edit() -> LineEdit:
	return _line_edit


func set_label_value(text) -> void:
	if not text:
		return
	_name = text
	if not text is String:
		_name = String(text)
	if _name_label:
		_name_label.text = _name.capitalize()
		_update_ui_size()


func set_value_no_undo(new_value) -> void:
	value = new_value


func set_style(val) -> void:
	style = val
	_update_style()


func _update_line_edit_value(value) -> void:
	_line_edit.text = String(value)


func _update_ui_size() -> void:
	rect_min_size = get_child(0).rect_size
	update()


func _update_style() -> void:
	match style:
		0:
			add_stylebox_override("bg", _bg_top)
			add_stylebox_override("fg", _fg_top)
		1:
			add_stylebox_override("bg", _bg_middle)
			add_stylebox_override("fg", _fg_middle)
		2:
			add_stylebox_override("bg", _bg_bottom)
			add_stylebox_override("fg", _fg_bottom)
		3:
			add_stylebox_override("bg", _bg)
			add_stylebox_override("fg", _fg)


func _on_button_pressed(increase: bool) -> void:
	if increase:
		_create_undo_redo_action(value + step, value)
	else:
		_create_undo_redo_action(value - step, value)
	_update_line_edit_value(value)


func _on_line_edit_changed(text = "") -> void:
	if text == "":
		text = _line_edit.text
	_create_undo_redo_action(float(text), value)
	if text != String(value):
		_line_edit.text = String(value)
	_update_ui_size()


func _on_value_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_clicked = event.pressed
		_acc = 0.0
		if _clicked:
			_previous_value = value
		else:
			_create_undo_redo_action(value, _previous_value)

	elif event is InputEventMouseMotion and _clicked:
		if sign(_acc) != sign(event.relative.x):
			_acc = 0.0

		_acc += event.relative.x
		if abs(_acc) >= min(max(5, 20 * step), 20):
			if step < 1:
				value += sign(_acc)
			else:
				value += sign(_acc) * step
			_acc = 0.0


func _create_undo_redo_action(new, old) -> void:
	new = stepify(new, step)
	if new == old:
		return

	if not undo_redo:
		value = new
		return

	undo_redo.create_action("Change " + _name_label.text + " value")
	undo_redo.add_do_property(self, "value", new)
	undo_redo.add_undo_property(self, "value", old)
	undo_redo.commit_action()
