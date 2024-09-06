extends Control

func _ready():
	EffectManager._initialize_effector(self)
	$BtnEnd.connect("button_down",self,"on_back")
	set_all_abilities(1)
	set_all_abilities(2)
	set_all_abilities(3)
	yield(get_tree().create_timer(.1),"timeout")
	$Player1.ALL_SLATS_ACTIVES = true
	$Player1.create_slats()
	$Player2.ALL_SLATS_ACTIVES = true
	$Player2.create_slats()
	$Player3.ALL_SLATS_ACTIVES = true
	$Player3.create_slats()

func set_all_abilities(player_id):
	var abs_arr = get_abailable_abilities_array(player_id)
	for btn in get_node("UI"+str(player_id)+"/VBoxAbs").get_children():
		if btn.get_index()<abs_arr.size(): 
			btn.set_data( abs_arr[btn.get_index()] )
			btn.connect("on_click",self,"on_select_ability",[btn,player_id])
		else: btn.set_data(null)
	for sbtn in get_node("UI"+str(player_id)+"/VBoxSlats").get_children():
		(sbtn as Button).connect("button_down",self,"on_select_slat",[sbtn,player_id])
		EffectManager.add_hint(sbtn,"upg_slat_"+sbtn.name)
		EffectManager.add_over_fx(sbtn,"rect")

func get_abailable_abilities_array(player_id):
	var array = AbilityManager.ABILITIES.keys()
	var pdata = PlayerManager.players[player_id-1]
	for ab_data in pdata.abilities: array.erase(ab_data.name)
	var i = 0
	while i<array.size():
		var ab_data = AbilityManager.get_ability(array[i])
		if !ab_data.classes.has("all") && !ab_data.classes.has(pdata.class):
			array.erase(ab_data.name)
		else: i+=1
	array.shuffle()
	return array

func check_player_have_ability(player_id,ab_code):
	for ab in PlayerManager.players[player_id-1].abilities:
		if ab.name == ab_code: return true
	return false

func on_back():
	get_tree().change_scene("res://scenes/Game.tscn")

func on_select_ability(ab_code,btn,player_id):
	AbilityManager.add_ability_to_player(ab_code,player_id-1)
	get_node("UI"+str(player_id)).visible = false

func on_select_slat(btn, player_id):
	if(btn.name=="HP"):
		PlayerManager.players[player_id-1].slats[btn.name] += 1
		get_node("Player"+str(player_id)).create_slats()
	else:
		PlayerManager.players[player_id-1].hpm += 2
		get_node("Player"+str(player_id)).heal(2)
	get_node("UI"+str(player_id)).visible = false

