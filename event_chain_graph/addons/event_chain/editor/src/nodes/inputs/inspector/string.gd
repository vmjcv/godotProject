tool
extends EventChainNode


func _init() -> void:
	unique_id = "inspector_string"
	display_name = "String Property"
	category = "Inputs/Inspector"
	description = "Expose a String value to the inspector"

	set_input(0, "Name", EventChainGraphDataType.STRING, {"disable_slot": true})
	set_input(1, "Default", EventChainGraphDataType.STRING, {"disable_slot": true})
	set_output(0, "", EventChainGraphDataType.STRING)


func _ready() -> void:
	connect("input_changed", self, "_on_input_changed")


func _generate_outputs() -> void:
	var name: String = get_input_single(0, "")
	var value = get_parent().get_value_from_inspector(name)

	if value == null:
		value = get_input_single(1, "N/A")

	output[0] = value


func get_exposed_variables() -> Array:
	var name: String = get_input_single(0)
	if not name:
		return []

	return [{
		"name": name,
		"type": EventChainGraphDataType.STRING,
		"default_value": get_input_single(1),
		}]


func _on_input_changed(slot: int, _value) -> void:
	if slot == 0:
		get_parent().update_exposed_variables()
