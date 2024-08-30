extends Node2D
class_name Defiance

var defiance_data

func _ready(): pass

func set_data(_data):
	defiance_data = _data
	defiance_data.node_ref = self
	$Sprite.material = null
	$Sprite.texture = load("res://assets/defiances/df_"+defiance_data["code"]+".png")
	EffectManager.add_hint($TargetButton,"one_defiance")
	AbilityManager.connect("on_select_ability",self,"on_select_ability")
	if defiance_data.type != "enemy": $atk.visible = false
	else: $atk/Label.text = str(defiance_data.damage)
	$hp/Label.text = str(defiance_data.dif)
	if defiance_data.type != "enemy": $hp.texture = preload("res://assets/bbimg/gear.png")

func on_select_ability(adata):
	$TargetButton.disconnect("button_down",AbilityManager,"on_click_target")
	if adata && adata.target.has(defiance_data.type): 
		$TargetButton.connect("button_down",AbilityManager,"on_click_target",[defiance_data])
		$Sprite.material = preload("res://shaders/outline.tres")
	else:
		$Sprite.material = null

func reduce_defiance(amount=1):
	defiance_data["dif"] -= amount
	$hp/Label.text = str(defiance_data.dif)
	yield(get_tree().create_timer(.3),"timeout")
	if defiance_data["dif"] <= 0: 
		if DefianceManager.has_method("on_resolve_defiance_"+defiance_data.type):
			DefianceManager.call("on_resolve_defiance_"+defiance_data.type, defiance_data)
		else: EffectManager.destroy_node_with_effect(self)

func _exit_tree():
	DefianceManager._on_destroyed_defiance()
#func update_labels():
#	$Action/Label.text = defiance_data["action_name"]
#	$Lb_danger.visible = "damage" in defiance_data
#	if $Lb_danger.visible: $Lb_danger.text = Utils.repeated_string("!",defiance_data.damage)
#	$Action/Label_amount.text = Utils.repeated_string("*",defiance_data.action_amount)
#
#func on_mouse_enter_action_area(val):
#	$Action/Label.visible = val
