tool
extends HBoxContainer


export var edit_tool_selected_group : ButtonGroup
onready var reference_line = $reference_line
onready var instan_flow_line = $instan_flow_line
onready var delay_flow_line = $delay_flow_line
onready var if_branch = $if
onready var match_branch = $match


func _ready():
	pass


func get_now_select_type():
	match edit_tool_selected_group.get_pressed_button():
		reference_line:
			return EditConstant.edit_type.REFERENCE_LINE
		instan_flow_line:
			return EditConstant.edit_type.INSTAN_FLOW_LINE
		delay_flow_line:
			return EditConstant.edit_type.DELAY_FLOW_LINE
		if_branch:
			return EditConstant.edit_type.IF_BRANCH
		match_branch:
			return EditConstant.edit_type.MATCH_BRANCH
