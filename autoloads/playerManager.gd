extends Node

var current_player_node
var players = []

signal on_select_player(player_data)

func _ready():
	init_players_data(3)

func init_players_data(amount):
	randomize()
	print("CREATE PLAYERS")
	for i in range(amount):
		players.append({
			"index":i,
			"retrait":i+1,
			"hp":6,"hpm":6,
			"items":[],
			"abilities":[],
			"slats":{"SW":0, "GR":0, "EY":0, "BT":0, "SC":0, "SH":0},
			"node_ref": null
		})
		for j in rand_range(8,12): 
			var s = SlatsManager.SLAT_TYPES[ randi()%SlatsManager.SLAT_TYPES.size() ]
			players[i].slats[s] += 1
		AbilityManager.add_ability_to_player("direct_attack",i)

func select_player(index):
	var pdata = PlayerManager.players[index]
	if current_player_node: current_player_node._internal_select(false)
	current_player_node = pdata.node_ref
	current_player_node._internal_select(true)
	emit_signal("on_select_player",pdata)

#func get_player_data(index = current_player_index):
#	return players[index]
#
#func get_player_room_data(index = current_player_index):
#	var player_data = get_player_data(index)
#	return MapGenerator.get_room_data(player_data.posX,player_data.posY)
#
#func player_data_inc(k,v):
#	var player_data = get_player_data()
#	player_data[k] += v
#	if player_data[k]<0: 
#		player_data[k] = 0
#		emit_signal("update_player_data",player_data)
#		return false
#	if k+"m" in player_data: player_data[k] = min(player_data[k],player_data[k+"m"])
#	emit_signal("update_player_data",player_data)
#	return true
#
#func player_data_set(k,v):
#	var player_data = get_player_data()
#	player_data[k] = v
#	emit_signal("update_player_data",player_data)
#
##func get_player_token(index = current_player_index):
##	return PLAYER_TOKENS_CONTAINER.get_child(current_player_index)
#
#func damage_player(dam=1):
#	var player_data = get_player_data()
#	player_data.hp -= 1
#	if dam>0: 
#		EffectManager.shake(player_data.token_ref)
#		EffectManager.dissappear(GAME.get_node("CanvasLayerUI/DamageColor"))
#	emit_signal("update_player_data",player_data)
#
#func set_current_player(index):
#	print("SET CURRENT PLAYER ",index)
#	current_player_index = index
#	set_player_tokens()
#	emit_signal("update_player_data",get_player_data())
#
#func set_next_player():
#	get_player_data().token_ref.z_index = 0
#	current_player_index += 1
#	if current_player_index >= players.size():
#		current_player_index = 0
#	set_current_player(current_player_index)
#
#func move_player_to(dir):
#	print(dir)
#	if !PlayerManager.player_data_inc("mv",-1): return
#	var pdata = get_player_data()
#	pdata.posX += dir.x
#	pdata.posY += dir.y
#	pdata.token_ref.position = get_player_room_data().node_ref.position
#	focus_camera()
##	for pd in players:
##		if pdata!=pd && pd.posX==pdata.posX && pd.posX==pdata.posX:
##			pdata.token_ref.z_index = 0
##	
#
#func focus_camera():
#	GAME.get_node("Camera2D").position = get_player_room_data().node_ref.position
#
#func set_player_tokens():
#	var offset = -40
#	for pd in players:
#		var room_data = MapGenerator.get_room_data(pd.posX,pd.posY)
#		if pd.index != current_player_index:
#			pd.token_ref.position.x = room_data.node_ref.position.x+offset
#			offset *= -1
#			pd.token_ref.z_index = 0
#		else: pd.token_ref.z_index = 1
