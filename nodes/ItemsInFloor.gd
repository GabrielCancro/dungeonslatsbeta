extends ColorRect

func _ready():
	ItemManager.connect("on_pick_drop_item",self,"update_items_in_floor")
	update_items()

func update_items():
	var items = ItemManager.items_in_room_floor
	Utils.remove_all_childs($VBox)
	for idata in items:
		var inode = preload("res://nodes/ItemNode.tscn").instance()
		inode.set_data(idata)
		$VBox.add_child(inode)
