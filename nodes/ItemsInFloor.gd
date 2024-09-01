extends ColorRect

func _ready():
	ItemManager.connect("on_add_remove_items",self,"update_items")
	update_items()

func update_items():
	var items = ItemManager.items_in_room_floor
	Utils.remove_all_childs($VBox)
	for idata in items: if idata.uses<=0: items.erase(idata)
	for idata in items:
		print("UPDATE ",idata.name)
		var inode = preload("res://nodes/ItemNode.tscn").instance()
		inode.set_data(idata,"on_floor")
		$VBox.add_child(inode)
