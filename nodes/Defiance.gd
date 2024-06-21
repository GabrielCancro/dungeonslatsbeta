extends Node2D

var defiance_data

func _ready(): pass

func set_data(_data):
	defiance_data = _data
	$Sprite.texture = load("res://assets/defiances/df_"+defiance_data["code"]+".png")
	EffectManager.add_hint($TargetButton,"one_defiance")
	$TargetButton.connect("button_down",self,"on_click_target")
	
	if defiance_data.type != "enemy": $atk.visible = false
	else: $atk/Label.text = str(defiance_data.damage)
	$hp/Label.text = str(defiance_data.dif)
	
	if defiance_data.type != "enemy": $hp.texture = preload("res://assets/bbimg/gear.png")

func on_click_target():
	print("TARGET ",defiance_data.type)
#	update_labels()
#	for nr in $Action/Req.get_children(): nr.visible = false
#	var index = 0
#	for type in defiance_data.action_req.keys():
#		for i in range(defiance_data.action_req[type]):
#			$Action/Req.get_child(index).texture = load("res://assets/slats/"+type+".png")
#			#$Action/Req.get_child(index).modulate = SlatsManager.get_color(type)
#			$Action/Req.get_child(index).visible = true
#			index+=1
#
#func reduce_defiance_level(amount=1):
#	defiance_data["action_amount"] -= amount
#	update_labels()
#	yield(get_tree().create_timer(.3),"timeout")
#	if defiance_data["action_amount"] <= 0: DefianceManager.on_resolve_defiance(defiance_data)
#
#func update_labels():
#	$Action/Label.text = defiance_data["action_name"]
#	$Lb_danger.visible = "damage" in defiance_data
#	if $Lb_danger.visible: $Lb_danger.text = Utils.repeated_string("!",defiance_data.damage)
#	$Action/Label_amount.text = Utils.repeated_string("*",defiance_data.action_amount)
#
#func on_mouse_enter_action_area(val):
#	$Action/Label.visible = val
