extends Control

var have_danger

func _ready():
	for pt in $Defiances.get_children(): pt.visible = false
	DefianceManager.connect("destroyed_defiance",self,"update_door")
	$Button.connect("button_down",self,"on_click_door")
	create_defiances()
	update_door()

func create_defiances():
	var defiances = DungeonManager.get_defiances_by_level()
	randomize()
	for def_data in defiances:
		var point = $Defiances.get_child( randi() % int( min(3,$Defiances.get_children().size())) )
		var dnode = preload("res://nodes/Defiance.tscn").instance()
		dnode.set_data(def_data)
		$Defiances.add_child(dnode)
		dnode.position = point.position
		$Defiances.remove_child(point)
		point.queue_free()

func get_defiances():
	var res = []
	for df in $Defiances.get_children():
		if df is Defiance: res.append(df)
	return res

func on_click_door():
	print("on_click_door have_danger ",have_danger)
	if !have_danger: DungeonManager.goto_next_room()
	else: EffectManager.show_float_text("msg_have_enemies_yet")

func update_door():
	print("update_door  update_door  update_door")
	have_danger = false
	for df in $Defiances.get_children():
		if df is Defiance && df.defiance_data && df.defiance_data.dif>0 && df.defiance_data.type == "enemy": have_danger = true
	if have_danger: $Door.modulate = Color(.5,.5,.5,1)
	else: $Door.modulate = Color(1,1,1,1)
