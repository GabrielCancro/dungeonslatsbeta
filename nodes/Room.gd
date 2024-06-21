extends Control

func _ready():
	create_defiances()

func create_defiances():
	var points = $Enemies.get_children()
	for pnt in points:
		if randi()%100<50:
			var def_data = DefianceManager.get_random_defiance()
			var dnode = preload("res://nodes/Defiance.tscn").instance()
			dnode.set_data(def_data)
			$Enemies.add_child(dnode)
			dnode.position = pnt.position
		pnt.queue_free()
