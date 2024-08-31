extends Control

var it_data
var carry

func set_data(_it_data,_carry):
	it_data = _it_data
	carry = _carry
	it_data["node_ref"] = self
	$Sprite.frame = it_data.ico
	$ColorAble.visible = false
	EffectManager.add_hint($Button,"it_desc_"+it_data.name,it_data.req)
	EffectManager.add_hint($ColorAble,"it_desc_"+it_data.name,it_data.req)
#	$Button.text = Lang.get_text("ab_name_"+ab_data.name)+" "+str(ab_data["uses"])+"/"+str(ab_data["max_uses"])
	if carry=="on_floor": 
		$btn_drop.visible = false
		$Button.connect("button_down",ItemManager,"on_click_floor_item",[it_data])
	elif carry=="equipped": 
		$btn_drop.visible = true
		$btn_drop.connect("button_down",ItemManager,"on_click_drop_equipped_item",[it_data])
		$Button.connect("button_down",ItemManager,"on_use_item",[it_data])
		PlayerManager.connect("on_change_player_slats",self,"update_item_able")
	update_item_able()

func update_item_able():
	$Label.text = "x"+str(it_data.uses)
	if carry=="on_floor":
		$ColorAble.visible = false
	elif carry=="equipped":
		var player_node = PlayerManager.get_current_player_data()
		if player_node: $ColorAble.visible = !PlayerManager.get_current_player_data().node_ref.check_slats(it_data.req)

func _internal_select(val):
	$ColorRect.visible = val
