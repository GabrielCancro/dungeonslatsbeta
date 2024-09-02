extends Control

func _ready():
	EffectManager._initialize_effector(self)
	$BtnEnd.connect("button_down",self,"on_back")
	yield(get_tree().create_timer(.1),"timeout")
	$Player1.ALL_SLATS_ACTIVES = true
	$Player1.create_slats()
	$Player2.ALL_SLATS_ACTIVES = true
	$Player2.create_slats()
	$Player3.ALL_SLATS_ACTIVES = true
	$Player3.create_slats()
	set_all_abilities()

func set_all_abilities():
	var abs_arr = AbilityManager.ABILITIES.keys()
	(abs_arr as Array).shuffle()
	for btn in $UI1/VBox.get_children():
		if btn.get_index()<abs_arr.size(): btn.set_data( abs_arr[btn.get_index()] )
		else: btn.set_data(null)

func on_back():
	get_tree().change_scene("res://scenes/Game.tscn")
