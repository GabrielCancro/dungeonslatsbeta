extends Node

var DEFIANCES = {
	"goblin":{"type":"enemy", "damage":2, "action_amount":3, "action_name":"attack", "action_req":{"SW":1} },
	"trap1": {"type":"trap", "damage":1, "action_amount":1,  "action_name":"dissarm", "action_req":{"GR":2} },
	"chest1":{"type":"chest", "action_amount":2, "action_name":"unlock", "action_req":{"GR":1} }
}

signal end_defiance_effect

func get_defiance(code):
	var def = DEFIANCES[code].duplicate(true)
	def["code"] = code
	def["node_ref"] = null
	return def

func get_random_defiance():
	randomize()
	var rk = DEFIANCES.keys()[ randi()%DEFIANCES.keys().size() ]
	return get_defiance(rk)

func get_room_random_defiances():
	var room_defiances = []
	randomize()
	for i in range(4): if randi()%100<40: room_defiances.append(get_random_defiance())
	return room_defiances

func on_click_action(defiance_data):
	if SlatsManager.consume_slats(defiance_data.action_req): 
		var metod_name = "ac_"+defiance_data.type+"_"+defiance_data.action_name
		print("try call ",metod_name)
		if has_method(metod_name): call(metod_name,defiance_data)
	else: EffectManager.shake_rect(SlatsManager.SLATTER)

func on_end_defiance(defiance_data):
	var metod_name = "end_"+defiance_data.type
	print("try call ",metod_name)
	if has_method(metod_name): 
		EffectManager.zoom_yoyo(defiance_data.node_ref)
		yield(get_tree().create_timer(0.5),"timeout")
		call(metod_name,defiance_data)
		yield(get_tree().create_timer(1.0),"timeout")
	yield(get_tree().create_timer(.2),"timeout")
	emit_signal("end_defiance_effect")

func on_resolve_defiance(defiance_data):
	var metod_name = "resolve_"+defiance_data.type
	print("try call ",metod_name)
	if has_method(metod_name):
		call(metod_name,defiance_data)
		yield(get_tree().create_timer(1),"timeout")
	yield(get_tree().create_timer(.2),"timeout")
	emit_signal("end_defiance_effect")
	
	defiance_data.room_data.defiances.erase(defiance_data)
	EffectManager.destroy_node_with_effect(defiance_data.node_ref)

#ENEMY
func ac_enemy_attack(defiance_data):
	defiance_data.node_ref.reduce_defiance_level()
	EffectManager.shake(defiance_data.node_ref)

func end_enemy(defiance_data):
	PlayerManager.damage_player(defiance_data.damage)

func resolve_enemy(defiance_data): pass

#TRAP
func ac_trap_dissarm(defiance_data):
	defiance_data.node_ref.reduce_defiance_level()
	EffectManager.shake(defiance_data.node_ref)

func end_trap(defiance_data):
	PlayerManager.damage_player(defiance_data.damage)

func resolve_trap(defiance_data): pass

#CHEST
func ac_chest_unlock(defiance_data):
	defiance_data.node_ref.reduce_defiance_level()
	EffectManager.shake(defiance_data.node_ref)

func end_chast(defiance_data): pass

func resolve_chest(defiance_data):
	EffectManager.shake(defiance_data.node_ref)
