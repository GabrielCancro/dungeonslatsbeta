extends Control

export var index = 0
var player_data

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"create_slats")
	yield(get_tree().create_timer(.1),"timeout")
	player_data = PlayerManager.players[index]

func create_slats():
	Utils.remove_all_childs($slats)
	for sk in player_data.slats.keys():
		for n in range(player_data.slats[sk]):
			var snode = preload("res://nodes/Slat.tscn").instance()
			$slats.add_child(snode)
			snode.set_slat(sk)
	order_slats()

func order_slats():
	var i = 0
	var dp = 2*PI/$slats.get_child_count()
	randomize()
	var rnd = randf()*2*PI
	for snode in $slats.get_children():
#		yield(get_tree().create_timer(.05),"timeout")
		snode.goto_pos(Vector2(cos(-i*dp-rnd)*45,sin(-i*dp-rnd)*45))
		i+=1
