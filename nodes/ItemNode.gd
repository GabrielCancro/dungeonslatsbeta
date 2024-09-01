extends Control

var it_data

func set_data(_it_data,_carry):
	it_data = _it_data
	it_data["node_ref"] = self
	$Sprite.frame = it_data.ico
	$ColorAble.visible = false
	EffectManager.add_hint($Button,"it_desc_"+it_data.name,it_data.req)
	EffectManager.add_hint($ColorAble,"it_desc_"+it_data.name,it_data.req)
	$Button.connect("button_down",ItemManager,"on_use_item",[it_data])
	PlayerManager.connect("on_change_player_slats",self,"update_item")
	PlayerManager.connect("on_select_player",self,"update_item_from_payer")
	update_item()

func update_item():
	$Label.text = "x"+str(it_data.uses)
	var player_node = PlayerManager.get_current_player_data()
	if player_node: $ColorAble.visible = !PlayerManager.get_current_player_data().node_ref.check_slats(it_data.req)
	else: $ColorAble.visible = true

func update_item_from_payer(pdata):
	update_item()
