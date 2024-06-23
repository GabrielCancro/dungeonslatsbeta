extends ColorRect

var player_data

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	PlayerManager.connect("on_select_player",self,"update_player_data")

func update_player_data(pdata):
	AbilityManager.select_ability(null)
	if !pdata: 
		visible = false
		return
	player_data = pdata
	$Label.text = "PLAYER "+str(player_data.index)
	visible = true
	#UPDATE ABILITIES
	Utils.remove_all_childs($HBoxAbilities)
	for adata in player_data.abilities:
		var anode = preload("res://nodes/AbilityNode.tscn").instance()
		anode.set_data(adata)
		$HBoxAbilities.add_child(anode)

func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if !player_data or !just_pressed: return
	if Input.is_key_pressed(KEY_1) and just_pressed and player_data.abilities.size()>=1: AbilityManager.select_ability(player_data.abilities[0])
	if Input.is_key_pressed(KEY_2) and just_pressed and player_data.abilities.size()>=2: AbilityManager.select_ability(player_data.abilities[1])
	if Input.is_key_pressed(KEY_3) and just_pressed and player_data.abilities.size()>=3: AbilityManager.select_ability(player_data.abilities[2])
	if Input.is_key_pressed(KEY_4) and just_pressed and player_data.abilities.size()>=4: AbilityManager.select_ability(player_data.abilities[3])
	if Input.is_key_pressed(KEY_5) and just_pressed and player_data.abilities.size()>=5: AbilityManager.select_ability(player_data.abilities[4])
	if Input.is_key_pressed(KEY_6) and just_pressed and player_data.abilities.size()>=6: AbilityManager.select_ability(player_data.abilities[5])
	if Input.is_key_pressed(KEY_7) and just_pressed and player_data.abilities.size()>=7: AbilityManager.select_ability(player_data.abilities[6])
	if Input.is_key_pressed(KEY_8) and just_pressed and player_data.abilities.size()>=8: AbilityManager.select_ability(player_data.abilities[7])
	if Input.is_key_pressed(KEY_9) and just_pressed and player_data.abilities.size()>=9: AbilityManager.select_ability(player_data.abilities[8])
