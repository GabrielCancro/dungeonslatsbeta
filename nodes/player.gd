extends Control

export var index = 0
var player_data
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",PlayerManager,"select_player",[index])
	_internal_select(false)
	yield(get_tree().create_timer(.1),"timeout")
	player_data = PlayerManager.players[index]
	player_data.node_ref = self
	$retrait.texture = load("res://assets/retraits/token_retrait"+str(index+1)+".png")
	update_ui()

func update_ui():
	is_dead = player_data.hp<=0
	if is_dead: modulate = Color(.5,.5,.5)
	else: modulate = Color(1,1,1)
	$Label.text = str(player_data.hp)+"/"+str(player_data.hpm)
	$HpBar.value = player_data.hpm-player_data.hp
	$HpBar.max_value = player_data.hpm
#	for n in $HBoxMov.get_children():
#		n.visible = ( n.get_index()<=player_data.mvm-1 )
#		if player_data.mv>n.get_index(): n.modulate = Color(.9,.9,.1,1)
#		else:  n.modulate = Color(.3,.3,.2,1)

func create_slats():
	Utils.remove_all_childs($slats)
	if is_dead: return
	for sk in player_data.slats.keys():
		for n in range(player_data.slats[sk]):
			var snode = preload("res://nodes/Slat.tscn").instance()
			snode.set_slat(sk)
			$slats.add_child(snode)
	order_slats()

func order_slats():
	InputManager.disable_input(1.5)
	var i = 0
	var e = 0
	var dp = (360-90)*PI/180/$slats.get_child_count()
	randomize()
	var start_angle = (90+60)*PI/180#randf()*2*PI
	for snode in $slats.get_children():
		yield(get_tree().create_timer(.05),"timeout")
		snode.goto_pos(Vector2(cos(i*dp+start_angle)*50,sin(i*dp+start_angle)*50))
		i+=1
	PlayerManager.emit_signal("on_change_player_slats")


func consume_slats(req):
	var valid_slats = {"SW":0, "GR":0, "EY":0, "BT":0, "SC":0, "SH":0, "EN":0}
	for snode in $slats.get_children(): if snode.isValid: valid_slats[snode.type] += 1
	for key in req.keys(): if req[key]>valid_slats[key]: return false
	#CONSUME
	for key in req.keys(): for i in range(req[key]): consume_one_slat(key)
	PlayerManager.emit_signal("on_change_player_slats")
	return true

func check_slats(req):
	var valid_slats = {"SW":0, "GR":0, "EY":0, "BT":0, "SC":0, "SH":0, "EN":0}
	for snode in $slats.get_children(): if snode.isValid: valid_slats[snode.type] += 1
	for key in req.keys(): if req[key]>valid_slats[key]: return false
	return true

func consume_one_slat(slat_type):
	for snode in $slats.get_children(): 
		if ! snode.isValid: continue
		if snode.type != slat_type: continue
		snode.set_valid(false)
		EffectManager.flip_token_fx(snode,true)
		break

func restore_one_slat(slat_type):
	for snode in $slats.get_children(): 
		if snode.isValid: continue
		if snode.type != slat_type: continue
		snode.set_valid(true)
		EffectManager.flip_token_fx(snode,true)
		PlayerManager.emit_signal("on_change_player_slats")
		break

func reroll_slats(stype):
	for snode in $slats.get_children(): 
		if snode.type != stype: continue
		if snode.isValid: continue
		snode.roll()
		EffectManager.appear(snode)
	PlayerManager.emit_signal("on_change_player_slats")

func _internal_select(val):
	if val:
		$bg.modulate = Color(.7,.7,.3,1)
		EffectManager.to_rect_scale(self,1)
		rect_scale = Vector2(1,1)
	else: 
		$bg.modulate = Color(.1,.1,.1,1)
		EffectManager.to_rect_scale(self,0.85)

func remove_slats():
	for snode in $slats.get_children(): EffectManager.destroy_node_with_effect(snode)

func damage(dam):
	if is_dead: return
	if dam>0:
		EffectManager.shake_rect(self)
		player_data.hp -= dam
		if player_data.hp<0: player_data.hp = 0
		update_ui()

func heal(val):
	if is_dead: return
	if val>0:
		EffectManager.shake_rect(self)
		player_data.hp += val
		if player_data.hp>player_data.hpm: player_data.hp = player_data.hpm
		update_ui()
