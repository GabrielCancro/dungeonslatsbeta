extends Control

var ab_data

# Called when the node enters the scene tree for the first time.
func set_data(_ab_data):
	ab_data = _ab_data
	$Button.text = Lang.get_text("ab_name_"+ab_data.name)+" "+str(ab_data["uses"])+"/"+str(ab_data["max_uses"])
	$Button.connect("button_down",ItemManager,"on_click_ability",[ab_data])
	EffectManager.add_hint($Button,"ab_desc_"+ab_data.name)
