extends Node2D

var room_data


# Called when the node enters the scene tree for the first time.
func set_data(_room_data):
	room_data = _room_data
	room_data["node_ref"] = self
	if !room_data.doors.up && !room_data.doors.down: $Sprite.scale.y = 0.7
	if !room_data.doors.left && !room_data.doors.right: $Sprite.scale.x = 0.7
	create_defiances()

func create_defiances():
	randomize()
	$Defiances.visible = false
	for def_data in room_data.defiances:
		var dnode = preload("res://gameObjects/Defiance.tscn").instance()
		dnode.set_data(def_data,room_data)
		var def_point = $Defiances.get_child( randi()%$Defiances.get_child_count() )
		$Defiances.remove_child(def_point)
		dnode.position = def_point.position
		def_point.queue_free()
		add_child(dnode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
