extends Node

var ABILITIES = {
	"berserk":{"max_uses":3}
}

var ITEMS = {
	"short_sword":{"uses":3}
}

func get_ability(code_ab):
	var ab = ABILITIES[code_ab].duplicate()
	ab["name"] = code_ab
	if "max_uses" in ab: ab["uses"] = ab["max_uses"]
	return ab

func add_ability_to_player(code_ab,index=PlayerManager.current_player_index):
	var pdata = PlayerManager.get_player_data(index)
	pdata.abilities.append(get_ability(code_ab))

func on_click_ability(ab_data):
	print("USE ABILITY "+ab_data.name)
	var method_name = "on_use_"+ab_data.name
	if has_method(method_name): call(method_name,ab_data)

func on_use_berserk(ab_data):
	if ab_data["uses"]>0 && SlatsManager.consume_slats({"BT":2}):
		ab_data["uses"] -= 1
		yield(get_tree().create_timer(.3),"timeout")
		SlatsManager.SLATTER.add_valid_slats({"SW":2})
		PlayerManager.emit_signal("update_player_data",PlayerManager.get_player_data())

func get_item_data(code):
	var item_data = ITEMS[code].duplicate(true)
	item_data["name"] = code
	return item_data

func get_some_items():
	return [get_item_data("short_sword")]
