extends Control

# Called when the node enters the scene tree for the first time.
func _ready(): pass
#	SlatsManager._init_slat_manager(self)
#	PlayerManager._initialize_player_manager(self)
#	EffectManager._initialize_effector(self)
#	MapGenerator.generate_new_map(30,false)
#	$CanvasLayerUI/BtnEndTurn.connect("button_down",self,"end_turn")
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

#func end_turn():
#	var room_data = PlayerManager.get_player_room_data()
#	for defiance_data in room_data.defiances:
#		DefianceManager.on_end_defiance(defiance_data)
#		yield(DefianceManager,"end_defiance_effect")
#
#	yield(get_tree().create_timer(.5),"timeout")
#	room_data = null
#	while !room_data:
#		PlayerManager.set_next_player()
#		PlayerManager.player_data_inc("mv",99)
#		SlatsManager.clear_slats()
#		room_data = PlayerManager.get_player_room_data()
#
#	PlayerManager.focus_camera()
	
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
