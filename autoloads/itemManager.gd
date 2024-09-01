extends Node

signal on_add_remove_items

onready var items_in_room_floor = [
	ItemManager.get_item("small_sword"),
	ItemManager.get_item("large_sword"),
	ItemManager.get_item("small_hp_potion")
]

var ITEMS = {
	"small_sword":{"ico":1,"type":"weapon", "uses":5, "req":{"EN":1} },
	"large_sword":{"ico":2,"type":"weapon", "uses":5, "req":{"EN":1} },
	"small_hp_potion":{"ico":80,"type":"use", "uses":2, "req":{"EN":1} },
}

func get_item(code):
	var it = ITEMS[code].duplicate()
	it["name"] = code
	return it

func on_use_item(it_data):
	if it_data && has_method("use_item_"+it_data.name): 
		it_data.uses -= 1
		PlayerManager.get_current_player_data().node_ref.consume_slats(it_data.req)
		InputManager.disable_input(.7)
		yield(get_tree().create_timer(.3),"timeout")
		call("use_item_"+it_data.name,PlayerManager.get_current_player_data(),it_data)
		if it_data.uses<=0: 
			EffectManager.dissappear(it_data.node_ref)
			InputManager.disable_input(.7)
			yield(get_tree().create_timer(.6),"timeout")
			emit_signal("on_add_remove_items")

func use_item_small_sword(pdata,it_data):
	pdata.node_ref.restore_one_slat("SW")

func use_item_large_sword(pdata,it_data):
	pdata.node_ref.restore_one_slat("SW")
	yield(get_tree().create_timer(.3),"timeout")
	pdata.node_ref.restore_one_slat("SW")

func use_item_small_hp_potion(pdata,it_data):
	pdata.node_ref.heal(2)
