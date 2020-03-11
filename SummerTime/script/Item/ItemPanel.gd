extends CenterContainer

func add_slot(slot_node,i):
	slot_node.rect_min_size = Vector2(60,60)
	slot_node.rect_size = Vector2(60,60)
	get_node("IconPanel").add_child(slot_node)
	slot_node.name = "Slot%s"%i
	slot_node.add_to_group("ItemSlot")
