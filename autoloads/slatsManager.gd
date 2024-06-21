extends Node

var GAME
var SLATTER
const it = .65
var SLAT_TYPES = ["SW","GR","EY","BT","SC","SH"]


# Called when the node enters the scene tree for the first time.
#func _init_slat_manager(_GAME):
#	GAME = _GAME
#	SLATTER = GAME.get_node("CanvasLayerUI/Slatter")
#
#func assign_slat(type):
#	var slat = SLATTER.get_valid_slat(type)
#	if slat:
#		slat.consume()
#		SLATTER.valid_slats[slat.type] -= 1
#		return true
#	return false

#func consume_slats(req):
#	var slats = PlayerManager.current_player_node.player_data.get_slats
#	for k in req.keys():
#		if SLATTER.valid_slats[k]<req[k]: return false
#	for k in req.keys():
#		for i in range(req[k]):
#			assign_slat(k)
#	return true

#func get_color(type):
#	return Color(1,1,1)
##	return SLAT_COLORS[type]
#
#func clear_slats():
#	SLATTER.clear_all_slats()
