extends Control

func _ready():
	PlayerManager.connect("update_player_data",self,"update_sheet")
	add_hint_slats()

func update_sheet(pdata): 
	if pdata != PlayerManager.get_player_data(): return
	$Retrait.texture = load("res://assets/retraits/token_retrait"+str(pdata.retrait)+".png")
	$Label.text = "Player "+str(PlayerManager.current_player_index+1)
	$Label.text += "\nHP "+str(pdata.hp)+"/"+str(pdata.hpm)
	$Label.text += "\nMV "+str(pdata.mv)+"/"+str(pdata.mvm)
	$Label.text += "\nFEAT "+str(pdata.feat)
	update_slats(pdata)
	update_abilities(pdata)

func add_hint_slats():
	for n in $HBoxSlats.get_children():
		EffectManager.add_hint(n,"slat_"+SlatsManager.SLAT_COLORS.keys()[n.get_index()])

func update_slats(pdata):
	var i = 0
	for k in SlatsManager.SLAT_COLORS.keys():
		$HBoxSlats.get_child(i).texture = load("res://assets/slats/"+k+".png")
		var node = $HBoxSlats.get_child(i)
		if k in pdata.slats && pdata.slats[k]>0: 
			node.modulate = Color(1,1,1,1)
			node.get_node("Label").text = str(pdata.slats[k])
		else: 
			node.modulate = Color(.3,.3,.3,1)
			node.get_node("Label").text = "x"
		i+=1

func update_abilities(pdata):
	Utils.remove_all_childs($Abilities)
	for ab_data in pdata.abilities:
		var abnode = preload("res://gameObjects/AbilityLine.tscn").instance()
		abnode.set_data(ab_data)
		$Abilities.add_child(abnode)
