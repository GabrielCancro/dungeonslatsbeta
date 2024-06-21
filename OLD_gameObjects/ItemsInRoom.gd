extends Control

var items_in_room = []

func _ready():
	PlayerManager.connect("update_player_data",self,"update_item_list")

func update_item_list(player_data):
	Utils.remove_all_childs($VBoxContainer)
	items_in_room = PlayerManager.get_player_room_data(player_data.index).items
	for it in items_in_room:
		var it_node = preload("res://gameObjects/ItemNode.tscn").instance()
		it_node.set_data(it)
		$VBoxContainer.add_child(it_node)
