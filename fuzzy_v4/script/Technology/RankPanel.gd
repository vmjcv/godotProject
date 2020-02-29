extends CenterContainer

func add_slot(slot_node,category,rank,i):
	slot_node.rect_min_size = Vector2(60,60)
	slot_node.rect_size = Vector2(60,60)
	get_node("IconPanel").add_child(slot_node)
	slot_node.name = "Slot%s"%i
	slot_node.add_to_group("TechnologySlot")
	slot_node.category = category
	slot_node.rank = rank
	slot_node.id = i
