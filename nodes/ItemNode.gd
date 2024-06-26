extends Control

var it_data

func set_data(it_data):
	it_data = it_data
	it_data["node_ref"] = self
	$Sprite.frame = it_data.ico
#	$Button.text = Lang.get_text("ab_name_"+ab_data.name)+" "+str(ab_data["uses"])+"/"+str(ab_data["max_uses"])
#	$Button.connect("button_down",AbilityManager,"select_ability",[it_data])
	EffectManager.add_hint($Button,"it_desc_"+it_data.name)
