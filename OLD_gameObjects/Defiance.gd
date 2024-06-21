extends Node2D

var defiance_data

func set_data(_data,room_data):
	defiance_data = _data
	defiance_data["node_ref"] = self
	defiance_data["room_data"]  = room_data
	$Sprite.texture = load("res://assets/defiances/df_"+defiance_data["code"]+".png")
	
	$Action/Button.connect("mouse_entered",self,"on_mouse_enter_action_area",[true])
	$Action/Button.connect("mouse_exited",self,"on_mouse_enter_action_area",[false])
	$Action/Button.connect("button_down",DefianceManager,"on_click_action",[defiance_data])
	
	update_labels()
	for nr in $Action/Req.get_children(): nr.visible = false
	var index = 0
	for type in defiance_data.action_req.keys():
		for i in range(defiance_data.action_req[type]):
			$Action/Req.get_child(index).texture = load("res://assets/slats/"+type+".png")
			#$Action/Req.get_child(index).modulate = SlatsManager.get_color(type)
			$Action/Req.get_child(index).visible = true
			index+=1

func reduce_defiance_level(amount=1):
	defiance_data["action_amount"] -= amount
	update_labels()
	yield(get_tree().create_timer(.3),"timeout")
	if defiance_data["action_amount"] <= 0: DefianceManager.on_resolve_defiance(defiance_data)

func update_labels():
	$Action/Label.text = defiance_data["action_name"]
	$Lb_danger.visible = "damage" in defiance_data
	if $Lb_danger.visible: $Lb_danger.text = Utils.repeated_string("!",defiance_data.damage)
	$Action/Label_amount.text = Utils.repeated_string("*",defiance_data.action_amount)

func on_mouse_enter_action_area(val):
	$Action/Label.visible = val
