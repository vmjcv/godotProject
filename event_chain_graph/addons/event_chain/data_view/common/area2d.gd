tool
extends Area2D


var hit_objects = [];


func _physics_process(delta):
	var space_rid = get_world_2d().space;
	var space_state = Physics2DServer.space_get_direct_state(space_rid);
	
	var mouse_position = get_global_mouse_position()
	
	var not_in_objects = hit_objects.duplicate()
	hit_objects = []
	var results = space_state.intersect_point(mouse_position,32,[],0x7fffffff,true,true)
	for result in results:
		if result["collider"] == self:
			if (hit_objects.has(result["collider"]) == false):
				hit_objects.append(result["collider"])
				result["collider"].emit_signal("mouse_entered")
					
			if (not_in_objects.has(result["collider"])):
				not_in_objects.remove(not_in_objects.find(result["collider"]))
	
	for not_in_object in not_in_objects:
		not_in_object.emit_signal("mouse_exited")
			
