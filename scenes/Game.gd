extends Control

# Called when the node enters the scene tree for the first time.
func _ready(): 
	EffectManager._initialize_effector(self)
	$CanvasLayerUI/BtnEndTurn.connect("button_down",self,"end_turn")
	yield(get_tree().create_timer(1.5),"timeout")
	for p in PlayerManager.players: p.node_ref.create_slats()
#	for room_name in MapGenerator.rooms:
#		var room_data = MapGenerator.rooms[room_name]
#		var rnode = preload("res://gameObjects/Room.tscn").instance()
#		rnode.set_data(room_data)
#		rnode.position = Vector2(room_data.posX,room_data.posY)*room_size
#		$Map.add_child(rnode)
#
#	for door_data in MapGenerator.doors:
#		#print(door_data)
#		var dnode = preload("res://gameObjects/Door.tscn").instance()
#		var pos = door_data.tileA + (door_data.tileB - door_data.tileA)/2
#		dnode.position = pos*room_size
#		dnode.set_data(door_data)
#		$Map.add_child(dnode)

func on_click_roll():
	for p in PlayerManager.players:
		p.node_ref.create_slats()

#func _process(delta):
#	if Input.is_action_pressed("ui_up"): $Camera2D.position.y -= vel
#	if Input.is_action_pressed("ui_down"): $Camera2D.position.y += vel
#	if Input.is_action_pressed("ui_left"): $Camera2D.position.x -= vel
#	if Input.is_action_pressed("ui_right"): $Camera2D.position.x += vel
#	if Input.is_action_just_pressed("ui_zoom_in"): 
#		$Camera2D.zoom *= .9
#		print("ZOOM ",$Camera2D.zoom.x)
#	if Input.is_action_just_pressed("ui_zoom_out"): 
#		$Camera2D.zoom *= 1.1
#		print("ZOOM ",$Camera2D.zoom.x)

func end_turn():
	PlayerManager.unselect_player()
	for p in PlayerManager.players: p.node_ref.remove_slats()
	yield(get_tree().create_timer(.5),"timeout")
	for dnode in $Room.get_defiances():
		if DefianceManager.has_method("on_turn_defiance_"+dnode.defiance_data.type):
			EffectManager.zoom_yoyo(dnode)
			DefianceManager.call("on_turn_defiance_"+dnode.defiance_data.type,dnode.defiance_data)
			yield(DefianceManager,"end_defiance_effect")

	yield(get_tree().create_timer(1.5),"timeout")
	for p in PlayerManager.players: p.node_ref.create_slats()
	
#	for def in MapManager.current_room.data.tokens:
#		if !card: continue
#		CardManager.run_action(card)
#		yield(CardManager,"end_all_actions")
#		yield(get_tree().create_timer(.2),"timeout")
#	yield(get_tree().create_timer(.5),"timeout")
#	$DiceSet.reset_set()
#	PlayerManager.set_next_player()
#	PlayerManager.player_data_inc("mv",99)
#	PlayerManager.player_data_inc("rl",99)
#	MapManager.load_current_player_room()
