extends Control

var ab_data

func set_data(_ab_data):
	ab_data = _ab_data
	ab_data["node_ref"] = self
	$Sprite.frame = ab_data.ico
	_internal_select(false)
#	$Button.text = Lang.get_text("ab_name_"+ab_data.name)+" "+str(ab_data["uses"])+"/"+str(ab_data["max_uses"])
	$Button.connect("button_down",AbilityManager,"select_ability",[ab_data])
	PlayerManager.connect("on_change_player_slats",self,"update_ability_able")
	EffectManager.add_hint($Button,"ab_desc_"+ab_data.name,ab_data.req)
	EffectManager.add_hint($ColorAble,"ab_desc_"+ab_data.name,ab_data.req)
	update_ability_able()

func update_ability_able():
	if !PlayerManager.get_current_player_data(): return
	var player_node = PlayerManager.get_current_player_data().node_ref
	$ColorAble.visible = !player_node.check_slats(ab_data.req)

func _internal_select(val):
	$ColorRect.visible = val
