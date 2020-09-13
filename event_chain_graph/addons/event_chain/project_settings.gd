tool
class_name EventChainGraphSettings

# 调用initialize在项目设置中添加相应选项

const USE_MODE = "event_chain_graph/use_mode/use_mode"

enum use_type {EDITOR,RUNTIME_IMAGE,RUNTIME_NO_IMAGE}

static func initialize() -> void:
	#_clear_old_options()
	_enable_option(USE_MODE, TYPE_STRING,PROPERTY_HINT_ENUM,"editor", "editor,runtime_image,runtime_no_image",PROPERTY_USAGE_CHECKED)


static func _clear_old_options() -> void:
	var old_settings := [
		"event_chain_graph/use_mode",
	]
	for name in old_settings:
		if ProjectSettings.has_setting(name):
			ProjectSettings.clear(name)


static func _enable_option(name, type,hint_type, default, hint_string := "",usage=PROPERTY_USAGE_DEFAULT) -> void:
	if ProjectSettings.has_setting(name):
		return

	ProjectSettings.set(name, default)
	var property_info = {
		"name": name,
		"type": type,
		"hint": hint_type,
		"hint_string": hint_string,
		"usage":usage,
	}
	ProjectSettings.add_property_info(property_info)

static func get_option(name):
	match name:
		USE_MODE:
			var result = ProjectSettings.get_setting(USE_MODE)
			match result:
				"editor":
					return use_type.EDITOR
				"runtime_image":
					return use_type.RUNTIME_IMAGE
				"runtime_no_image":
					return use_type.RUNTIME_NO_IMAGE
			
static func get_use_mode():
	return get_option(USE_MODE)
