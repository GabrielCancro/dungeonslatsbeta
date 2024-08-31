extends Node

signal on_pick_drop_item

onready var items_in_room_floor = [
	ItemManager.get_item("small_sword"),
	ItemManager.get_item("large_sword")
]

var ITEMS = {
	"small_sword":{"ico":1,"type":"weapon", "uses":5, "req":{"EN":1} },
	"large_sword":{"ico":2,"type":"weapon", "uses":5, "req":{"EN":1} },
}

func get_item(code):
	var it = ITEMS[code].duplicate()
	it["name"] = code
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

func on_use_item(it_data):
	if it_data && has_method("use_item_"+it_data.name): 
		it_data.uses -= 1
		if(it_data.uses<=0): PlayerManager.get_current_player_data().items.erase(it_data)
		PlayerManager.get_current_player_data().node_ref.consume_slats(it_data.req)
		InputManager.disable_input(1.5)
		yield(get_tree().create_timer(.4),"timeout")
		call("use_item_"+it_data.name,PlayerManager.get_current_player_data(),it_data)

func use_item_small_sword(pdata,it_data):
	pdata.node_ref.restore_one_slat("SW")

func use_item_large_sword(pdata,it_data):
	pdata.node_ref.restore_one_slat("SW")
	yield(get_tree().create_timer(.3),"timeout")
	pdata.node_ref.restore_one_slat("SW")
