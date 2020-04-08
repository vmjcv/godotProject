class_name InputHelper

static func is_action_pressed(e :InputEvent,action:String):
	return e.is_action_pressed(action)

static func is_action_just_pressed(e :InputEvent,action:String):
	return e.is_action_pressed(action) and not e.is_echo()
