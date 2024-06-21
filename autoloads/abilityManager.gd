extends Node

var current_ability_node
signal on_select_ability(adata)
var ABILITIES = {
	"direct_attack":{"ico":3,"max_uses":3,"target":["enemy"]}
}

func get_ability(code_ab):
	var ab = ABILITIES[code_ab].duplicate()
	ab["name"] = code_ab
	if "max_uses" in ab: ab["uses"] = ab["max_uses"]
	return ab

func add_ability_to_player(code_ab,index=PlayerManager.current_player_index):
	var pdata = PlayerManager.players[index]
	pdata.abilities.append(get_ability(code_ab))

func select_ability(adata):
	if !is_instance_valid(current_ability_node): current_ability_node = null
	if current_ability_node: current_ability_node._internal_select(false)
	if adata && current_ability_node!=adata.node_ref: 
		current_ability_node = adata.node_ref
		current_ability_node._internal_select(true)
	else: 
		current_ability_node = null
		adata = null
	emit_signal("on_select_ability",adata)

func on_click_target(defiance_data):
	var method_name = "ac_"+current_ability_node.ab_data.name+"_"+defiance_data.type
	if has_method(method_name): 
		call(method_name, PlayerManager.get_current_player_data(), current_ability_node.ab_data, defiance_data)

func ac_direct_attack_enemy(pdata, adata, ddata):
	print("ac_direct_attack_enemy")
	if(PlayerManager.get_current_player_data().node_ref.consume_slats({"SW":1})):
		ddata.node_ref.reduce_defiance(1)
		EffectManager.shake(ddata.node_ref)
	
#func on_click_ability(ab_data):
#	print("USE ABILITY "+ab_data.name)
#	var method_name = "on_use_"+ab_data.name
#	if has_method(method_name): call(method_name,ab_data)
#
#func on_use_berserk(ab_data):
#	if ab_data["uses"]>0 && SlatsManager.consume_slats({"BT":2}):
#		ab_data["uses"] -= 1
#		yield(get_tree().create_timer(.3),"timeout")
#		SlatsManager.SLATTER.add_valid_slats({"SW":2})
#		PlayerManager.emit_signal("update_player_data",PlayerManager.get_player_data())

#func get_item_data(code):
#	var item_data = ITEMS[code].duplicate(true)
#	item_data["name"] = code
#	return item_data
