extends Node

signal on_pick_drop_item

onready var items_in_room_floor = [
	ItemManager.get_item("small_sword"),
	ItemManager.get_item("large_sword")
]

var ITEMS = {
	"small_sword":{"ico":1,"type":"weapon", "max_uses":10},
	"large_sword":{"ico":2,"type":"weapon", "max_uses":10},
}

func get_item(code):
	var it = ITEMS[code].duplicate()
	it["name"] = code
	if "max_uses" in it: it["uses"] = it["max_uses"]
	return it

func refresh_items_in_room_floor():
	emit_signal("on_pick_drop_item")

func on_click_floor_item(item_data):
	var pdata = PlayerManager.get_current_player_data()
	if !pdata: return
	items_in_room_floor.erase(item_data)
	pdata.items.append(item_data)
	refresh_items_in_room_floor()

func on_click_drop_equipped_item(item_data):
	var pdata = PlayerManager.get_current_player_data()
	if !pdata: return
	pdata.items.erase(item_data)
	items_in_room_floor.append(item_data)
	refresh_items_in_room_floor()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
