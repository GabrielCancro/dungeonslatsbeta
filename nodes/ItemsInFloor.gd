extends ColorRect

func _ready():
	ItemManager.connect("on_pick_drop_item",self,"update_items")
	update_items()

func update_items():
	print("ITEMS IN FLOOR FROM PANEL")
	var items = ItemManager.items_in_room_floor
	Utils.remove_all_childs($VBox)
	for idata in items:
		var inode = preload("res://nodes/ItemNode.tscn").instance()
		inode.set_data(idata,"on_floor")
		$VBox.add_child(inode)
