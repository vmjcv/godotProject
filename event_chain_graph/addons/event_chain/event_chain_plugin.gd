tool
extends EditorPlugin

# 事件链插件是基于节点的内容创建工具。
# 该插件提供了一个基础框架：状态信息，触发事件，回调事件，
# 需注意游戏中可能同时存在多个事件链条，所以事件编号要是全局唯一的量
var now_mode 
var _editor_selection
var _graph_editor_view
var _panel_button
var _event_chain_graph

func _enter_tree() -> void:
	EventChainGraphSettings.initialize()
	init_use_mode()
	
func init_use_mode():
	match EventChainGraphSettings.get_use_mode():
		EventChainGraphSettings.use_type.EDITOR:
			# 编辑器模式
			_init_edit_mode()
			pass
		EventChainGraphSettings.use_type.RUNTIME_IMAGE:
			# 运行时有图模式
			pass
		EventChainGraphSettings.use_type.RUNTIME_NO_IMAGE:
			# 运行时无图模式
			pass
func _exit_tree() -> void:
	match now_mode:
		EventChainGraphSettings.use_type.EDITOR:
			# 编辑器模式
			_clear_edit_mode()
			pass
		EventChainGraphSettings.use_type.RUNTIME_IMAGE:
			# 运行时有图模式
			pass
		EventChainGraphSettings.use_type.RUNTIME_NO_IMAGE:
			# 运行时无图模式
			pass


func _init_edit_mode():
	_init_edit_mode_view()
	_connect_edit_mode_signals()
	pass
	
func _init_edit_mode_view():
	now_mode = EventChainGraphSettings.use_type.EDITOR

	_graph_editor_view = preload("res://addons/event_chain/editor/view.tscn").instance()
	#_graph_editor_view.undo_redo = get_undo_redo()
	_panel_button = add_control_to_bottom_panel(_graph_editor_view, "Event Chain Graph Editor")
	_panel_button.visible = true


func _clear_edit_mode():
	_clear_edit_mode_view()
	_disconnect_edit_mode_signals()
	
func _clear_edit_mode_view():	
	if _graph_editor_view:
		remove_control_from_bottom_panel(_graph_editor_view)
		_graph_editor_view.queue_free()

func _connect_edit_mode_signals() -> void:
	_editor_selection = get_editor_interface().get_selection()
	_editor_selection.connect("selection_changed", self, "_on_selection_changed")
	connect("scene_changed", self, "_on_scene_changed")
	connect("scene_closed", self, "_on_scene_changed")
	_on_selection_changed()


func _disconnect_edit_mode_signals() -> void:
	disconnect("scene_changed", self, "_on_scene_changed")
	disconnect("scene_closed", self, "_on_scene_changed")
	if _editor_selection:
		_editor_selection.disconnect("selection_changed", self, "_on_selection_changed")


func _on_selection_changed() -> void:
	# @:如果选择了新的EventChainGraph，请通知editor_view。 如果是另一种节点，则什么也不做，并保持编辑器处于打开状态。
	_editor_selection = get_editor_interface().get_selection()
	var selected_nodes = _editor_selection.get_selected_nodes()
	for node in selected_nodes:
		if node is EventChainGraph:
			_event_chain_graph = node
			_graph_editor_view.enable_edit_for(_event_chain_graph)
			return

func _on_scene_changed(_param) -> void:
	_graph_editor_view.clear_edit()
	_on_selection_changed()

