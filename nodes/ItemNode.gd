extends Control

var it_data

func set_data(it_data,carry):
	it_data = it_data
	it_data["node_ref"] = self
	$Sprite.frame = it_data.ico
	EffectManager.add_hint($Button,"it_desc_"+it_data.name)
#	$Button.text = Lang.get_text("ab_name_"+ab_data.name)+" "+str(ab_data["uses"])+"/"+str(ab_data["max_uses"])
	if carry=="on_floor": 
		$btn_drop.visible = false
		$Button.connect("button_down",ItemManager,"on_click_floor_item",[it_data])
	elif carry=="equipped": 
		$btn_drop.visible = true
		$btn_drop.connect("button_down",ItemManager,"on_click_drop_equipped_item",[it_data])
