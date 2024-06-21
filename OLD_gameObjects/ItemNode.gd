extends Control

var item_data
var in_room_floor = true

func _ready():
	$Button.connect("button_down",self,"on_click_item")

func set_data(data):
	item_data = data
	$Label.text = item_data.name
	EffectManager.add_hint($Button,"it_desc_"+item_data.name)

func on_click_item():
	print(item_data)
	EffectManager.shake_rect(self)
