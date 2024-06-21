extends Control

export var index = 0
var player_data

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",PlayerManager,"select_player",[index])
	_internal_select(false)
	yield(get_tree().create_timer(.1),"timeout")
	player_data = PlayerManager.players[index]
	player_data.node_ref = self
	$retrait.texture = load("res://assets/retraits/token_retrait"+str(index+1)+".png")

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
	var dp = (360-90)*PI/180/$slats.get_child_count()
	randomize()
	var rnd = (90+60)*PI/180#randf()*2*PI
	for snode in $slats.get_children():
		yield(get_tree().create_timer(.05),"timeout")
		snode.goto_pos(Vector2(cos(i*dp+rnd)*50,sin(i*dp+rnd)*50))
		i+=1

func _internal_select(val):
	if val:
		$bg.modulate = Color(.7,.7,.3,1)
		EffectManager.to_rect_scale(self,1)
		rect_scale = Vector2(1,1)
	else: 
		$bg.modulate = Color(.1,.1,.1,1)
		EffectManager.to_rect_scale(self,0.7)
