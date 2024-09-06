extends ColorRect

var ab_code
signal on_click(ab_code)

func _ready():
	yield(get_tree().create_timer(.1),"timeout")
	$Button.connect("button_down",self,"on_click_button")

func set_data(_ab_code):
	ab_code = _ab_code
	if !ab_code:
		visible = false
	else:
		$Label.text = Lang.get_text("ab_desc_"+ab_code).split(":")[0]
		$Sprite.frame = AbilityManager.ABILITIES[ab_code].ico
		EffectManager.add_hint($Button,"ab_desc_"+ab_code)
		EffectManager.add_over_fx($Button,"rect")

func on_click_button():
	emit_signal("on_click",ab_code)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
