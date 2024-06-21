extends Control

var action_data
var start_pos

func set_data(_data):
	action_data = _data
	action_data["node_ref"] = self
	$Label.text = action_data.name
	EffectManager.add_visible_on_hint($Button,$Label)
	$Button.connect("button_down",DefianceManager,"on_click_action",[action_data])
	
	for nr in $Req.get_children(): nr.visible = false
	var index = 0
	for type in action_data.req.keys():
		for i in range(action_data.req[type]):
			$Req.get_child(index).texture = load("res://assets/slats/"+type+".png")
			$Req.get_child(index).modulate = SlatsManager.get_color(type)
			$Req.get_child(index).visible = true
			index+=1
