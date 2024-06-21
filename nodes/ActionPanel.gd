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
