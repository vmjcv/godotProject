tool
class_name EventChainNodeLibrary
extends Node

# 检索所有可用的事件链图节点

var _nodes: Dictionary
var _node_search_index: Dictionary

func _exit_tree() -> void:
	clear()


func get_list() -> Dictionary:
	if not _nodes:
		refresh_list()
	return _nodes


func get_index_list() -> Dictionary:
	if not _node_search_index:
		refresh_list()
	return _node_search_index


func clear() -> void:
	for node in _nodes.values():
		node.queue_free()


func create_node(type: String) -> EventChainNode:
	if _nodes.has(type):
		return _nodes[type].duplicate()
	return null


func refresh_list() -> void:
	_node_search_index = Dictionary()
	clear()
	_nodes = Dictionary()

	# Current folder path points at the root project from here so we can't feed the Directory object
	# with a relative path. Instead we get the script path and build an absolute path from there.
	# Writing res://addons/concept_graph/src/nodes isn't an option because the end user can rename
	# the plugin folder.
	var script_path = get_script().get_path()
	var nodes_dir = script_path.replace("node_library.gd", "../nodes/")
	_find_all_nodes(nodes_dir)


"""
Recursively search all the scripts that inherits from ConceptNode and store them in the dictionnary
"""
func _find_all_nodes(path) -> void:
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	var path_root = dir.get_current_dir() + "/"

	while true:
		var file = dir.get_next()
		if file == "":
			break
		if dir.current_is_dir():
			_find_all_nodes(path_root + file)
			continue
		if not file.ends_with(".gd"):
			continue

		var full_path = path_root + file
		var script = load(full_path)
		if not script or not script.can_instance():
			print("Error: Failed to load script ", file)
			continue

		var node = script.new()
		var name = node.display_name
		var id = node.unique_id

		# ConceptNode is abstract, don't add it to the list
		if not (node is EventChainNode) or name == "EventChainNode":
			continue

		# If the interface is defined in a separate file, load it instead
		if node.has_custom_gui():
			node = load(path_root + file.replace(".gd", ".tscn")).instance()

		if _nodes.has(id):
			print("Warning: Node ", name, " has duplicate id ", full_path)
		else:
			_nodes[id] = node
			_node_search_index[node.display_name] = id
	dir.list_dir_end()
