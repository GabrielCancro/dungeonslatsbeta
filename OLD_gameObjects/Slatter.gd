extends Control

var slats = {"SW":4, "GR":4, "EY":4, "BT":4, "SC":4}
var valid_slats = {}
var is_rolling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for s in SlatsManager.SLAT_COLORS.keys(): valid_slats[s] = 0
	$Button.connect("button_down",self,"roll_slats")
	$Button2.connect("button_down",self,"reroll_slats")

func roll_slats():
	PlayerManager.player_data_inc("mv",-99)
	is_rolling = true
	slats = PlayerManager.get_player_data().slats
	for s in SlatsManager.SLAT_COLORS.keys(): valid_slats[s] = 0
	$Button.disabled = is_rolling
	Utils.remove_all_childs($SlatContainer)
	for key in slats.keys():
		for i in range(slats[key]):
			var slat_node = load("res://gameObjects/Slat.tscn").instance()
			slat_node.set_slat(key)
			$SlatContainer.add_child(slat_node)
	yield(get_tree().create_timer(1.2),"timeout")
	collect_slats()
	yield(get_tree().create_timer(2),"timeout")
	is_rolling = false
	$Button.disabled = is_rolling

func collect_slats():
	var pos = get_viewport_rect().size * Vector2(0.5,0.8)
	pos.x -= (100+$SlatContainer.get_children().size()*20) /2
	for slat in $SlatContainer.get_children():
		if !slat.isValid: continue
		valid_slats[slat.type] += 1
		yield(get_tree().create_timer(.06),"timeout")
		slat.goto_pos(pos)
		pos.x += 20
	pos.x += 100
	yield(get_tree().create_timer(.3),"timeout")
	for slat in $SlatContainer.get_children():
		if slat.isValid: continue
		yield(get_tree().create_timer(.03),"timeout")
		slat.goto_pos(pos)
		pos.x += 20
	print("VALID SLATS ",valid_slats)

func add_valid_slats(slats):
	for key in slats.keys():
		for i in range(slats[key]):
			var slat_node = load("res://gameObjects/Slat.tscn").instance()
			slat_node.set_slat(key)
			slat_node.set_valid(true)
			$SlatContainer.add_child(slat_node)
	yield(get_tree().create_timer(1.2),"timeout")
	collect_slats()

func reroll_slats():
	for s in SlatsManager.SLAT_COLORS.keys(): valid_slats[s] = 0
	for slat in $SlatContainer.get_children():
		if !slat.isValid: slat.roll()
	yield(get_tree().create_timer(1.2),"timeout")
	collect_slats()

func get_valid_slat(_type):
	for slat in $SlatContainer.get_children():
		if !slat.isValid: continue
		if slat.type!=_type: continue
		return slat
	return null

func clear_all_slats():
	Utils.remove_all_childs($SlatContainer)
	valid_slats = {}
