extends Control

var ab_data

func set_data(_ab_data):
	ab_data = _ab_data
	ab_data["node_ref"] = self
	$Sprite.frame = ab_data.ico
	_internal_select(false)
#	$Button.text = Lang.get_text("ab_name_"+ab_data.name)+" "+str(ab_data["uses"])+"/"+str(ab_data["max_uses"])
	$Button.connect("button_down",AbilityManager,"select_ability",[ab_data])
	EffectManager.add_hint($Button,"ab_desc_"+ab_data.name)

func _internal_select(val):
	$ColorRect.visible = val
