extends Node

var dungeon_level = 1
var room_num = 0
var room_max = 3

func get_defiances_by_level():
	print("get_defiances_by_level")
	var result = []
	for i in range( 1 + floor(dungeon_level/2) ): result.append( DefianceManager.get_random_defiance("enemy") )
	for i in range( floor(dungeon_level/2) ): result.append( DefianceManager.get_random_defiance("trap") )
	for i in range( floor(dungeon_level/3) ): result.append( DefianceManager.get_random_defiance("chest") )
	return result

func goto_next_room(is_first_creation=false):
	room_num += 1
	if room_num>room_max: 
		dungeon_level += 1
		room_num = 1
		room_max = 2+dungeon_level
	get_node("/root/Game/CanvasLayerUI/lb_level").text = "Dungeon\nLevel "+str(dungeon_level)+"\nSala "+str(room_num)+"/"+str(room_max)
	print("DUNGEON LEVEL ",dungeon_level)
	var CONTAINER = get_node("/root/Game/RoomContainer")
	var OLD_ROOM = get_node("/root/Game/RoomContainer/Room")
	var NEW_ROOM = preload("res://nodes/Room.tscn").instance()
	if is_first_creation:
		CONTAINER.remove_child(OLD_ROOM)
		OLD_ROOM.queue_free()
		CONTAINER.add_child(NEW_ROOM)
		yield(get_tree().create_timer(.1),"timeout")
	else:
		EffectManager.destroy_node_with_effect(OLD_ROOM)
		PlayerManager.unselect_player()
		for p in PlayerManager.players: p.node_ref.remove_slats()
		yield(get_tree().create_timer(.5),"timeout")
		NEW_ROOM.modulate.a = 0
		EffectManager.appear(NEW_ROOM)
		CONTAINER.add_child(NEW_ROOM)
		yield(get_tree().create_timer(1),"timeout")
	for p in PlayerManager.players: p.node_ref.create_slats()
