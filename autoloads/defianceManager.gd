extends Node

var DEFIANCES_ENEMY = {
	"goblin":{ "type":"enemy", "damage":1, "dif":2 },
	"skeleton":{ "type":"enemy", "damage":1, "dif":3 },
	"spider":{ "type":"enemy", "damage":2, "dif":2 },
}

var DEFIANCES_TRAP = {
	"trap1": { "type":"trap", "damage":1, "dif":2 },
}

var DEFIANCES_CHEST = {
	"chest1":{ "type":"chest", "dif":2 },
}

signal end_defiance_effect
signal destroyed_defiance

func get_defiance(code):
	var def
	if code in DEFIANCES_ENEMY: def = DEFIANCES_ENEMY[code].duplicate(true)
	if code in DEFIANCES_TRAP: def = DEFIANCES_TRAP[code].duplicate(true)
	if code in DEFIANCES_CHEST: def = DEFIANCES_CHEST[code].duplicate(true)
	def["code"] = code
	def["node_ref"] = null
	return def

func get_random_defiance(types=null):
	randomize()
	var DEFIANCES = {}
	"asdasd"
	if !types or types.find("enemy")!=-1: DEFIANCES.merge(DEFIANCES_ENEMY)
	if !types or types.find("trap")!=-1: DEFIANCES.merge(DEFIANCES_TRAP)
	if !types or types.find("chest")!=-1: DEFIANCES.merge(DEFIANCES_CHEST)
	var rk = DEFIANCES.keys()[ randi()%DEFIANCES.keys().size() ]
	return get_defiance(rk)
#
#func get_room_random_defiances():
#	var room_defiances = []
#	randomize()
#	for i in range(4): if randi()%100<40: room_defiances.append(get_random_defiance())
#	return room_defiances
#
#func on_click_action(defiance_data):
#	if SlatsManager.consume_slats(defiance_data.action_req): 
#		var metod_name = "ac_"+defiance_data.type+"_"+defiance_data.action_name
#		print("try call ",metod_name)
#		if has_method(metod_name): call(metod_name,defiance_data)
#	else: EffectManager.shake_rect(SlatsManager.SLATTER)
#
#func on_end_defiance(defiance_data):
#	var metod_name = "end_"+defiance_data.type
#	print("try call ",metod_name)
#	if has_method(metod_name): 
#		EffectManager.zoom_yoyo(defiance_data.node_ref)
#		yield(get_tree().create_timer(0.5),"timeout")
#		call(metod_name,defiance_data)
#		yield(get_tree().create_timer(1.0),"timeout")
#	yield(get_tree().create_timer(.2),"timeout")
#	emit_signal("end_defiance_effect")
#
func on_resolve_defiance_enemy(defiance_data):
	EffectManager.destroy_node_with_effect(defiance_data.node_ref)

func on_turn_defiance_enemy(defiance_data):
	yield(get_tree().create_timer(.3),"timeout")
	var pdata = PlayerManager.get_random_player_data()
	EffectManager.goto_and_back(defiance_data.node_ref,pdata.node_ref.rect_position+Vector2(0,-60))
	yield(get_tree().create_timer(.4),"timeout")
	pdata.node_ref.damage(defiance_data.damage)
	yield(get_tree().create_timer(.7),"timeout")
	emit_signal("end_defiance_effect")

func on_turn_defiance_trap(defiance_data):
	yield(get_tree().create_timer(.5),"timeout")
	for pdata in PlayerManager.players: pdata.node_ref.damage(defiance_data.damage)
	yield(get_tree().create_timer(.7),"timeout")
	emit_signal("end_defiance_effect")

func _on_destroyed_defiance():
	yield(get_tree().create_timer(1),"timeout")
	emit_signal("destroyed_defiance")

#	var metod_name = "resolve_"+defiance_data.type
#	print("try call ",metod_name)
#	if has_method(metod_name):
#		call(metod_name,defiance_data)
#		yield(get_tree().create_timer(1),"timeout")
#	yield(get_tree().create_timer(.2),"timeout")
#	emit_signal("end_defiance_effect")
#
#	defiance_data.room_data.defiances.erase(defiance_data)
#	EffectManager.destroy_node_with_effect(defiance_data.node_ref)
#
##ENEMY
#func ac_enemy_attack(defiance_data):
#	defiance_data.node_ref.reduce_defiance_level()
#	EffectManager.shake(defiance_data.node_ref)
#
#func end_enemy(defiance_data):
#	PlayerManager.damage_player(defiance_data.damage)
#
#func resolve_enemy(defiance_data): pass
#
##TRAP
#func ac_trap_dissarm(defiance_data):
#	defiance_data.node_ref.reduce_defiance_level()
#	EffectManager.shake(defiance_data.node_ref)
#
#func end_trap(defiance_data):
#	PlayerManager.damage_player(defiance_data.damage)
#
#func resolve_trap(defiance_data): pass
#
##CHEST
#func ac_chest_unlock(defiance_data):
#	defiance_data.node_ref.reduce_defiance_level()
#	EffectManager.shake(defiance_data.node_ref)
#
#func end_chast(defiance_data): pass
#
#func resolve_chest(defiance_data):
#	EffectManager.shake(defiance_data.node_ref)
