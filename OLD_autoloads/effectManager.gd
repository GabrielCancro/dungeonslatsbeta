extends Node

var GAME
onready var tween = Tween.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tween)

func _initialize_effector(_game):
	GAME = _game

func add_visible_on_hint(node_area,node_showed):
	node_showed.visible = false
	node_area.connect("mouse_entered",self,"on_visible_hint",[node_showed,true])
	node_area.connect("mouse_exited",self,"on_visible_hint",[node_showed,false])

func on_visible_hint(node,val):
	node.visible = val

func shake(node,power=2,time=.5):
	var ini_pos = node.position
	randomize()
	while time>0:
		if !is_instance_valid(node): return
		node.position = ini_pos + Vector2(rand_range(-power,power),rand_range(-power/2,power/2))
		time -= .025
		yield(get_tree().create_timer(.025),"timeout")
	node.position = ini_pos

func shake_rect(node,power=2,time=.5):
	var ini_pos = node.rect_position
	randomize()
	while time>0:
		if !is_instance_valid(node): return
		node.rect_position = ini_pos + Vector2(rand_range(-power,power),rand_range(-power/2,power/2))
		time -= .025
		yield(get_tree().create_timer(.025),"timeout")
	node.rect_position = ini_pos

func intro_actions(node):
	if node.visible: return
	node.modulate.a = 0
	node.visible = true
	var end = node.rect_position
	tween.interpolate_property(node,"rect_position",end+Vector2(-20,0),end,.1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,"modulate",Color(1,1,1,0),Color(1,1,1,1),.1,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()

func zoom_yoyo(node):
	var start = node.scale
	var zoom = Vector2(.2,.2)
	tween.interpolate_property(node,"scale",start,start+zoom,.2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,"scale",start+zoom,start,.2,Tween.TRANS_QUAD,Tween.EASE_IN,.7)
	tween.start()

func outro_actions(node):
	if node.modulate.a < 1: return
	var start = node.rect_position
	#tween.interpolate_property(node,"rect_position",start,start+Vector2(20,0),.3,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.interpolate_property(node,"modulate",node.modulate,Color(1,1,1,0),.1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	yield(get_tree().create_timer(.1),"timeout")
	node.visible = false
	#node.rect_position = start

func destroy_node_with_effect(node):
	tween.interpolate_property(node,"modulate",node.modulate,Color(1,1,1,0),.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	yield(get_tree().create_timer(.3),"timeout")
	node.get_parent().remove_child(node)
	node.queue_free()

func dissappear(node):
	node.visible = true
	tween.interpolate_property(node,"modulate:a",1,0,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	yield(get_tree().create_timer(.3),"timeout")
	node.visible = false

var hint_current_node
func add_hint(node,tx_code):
	node.connect("mouse_entered",self,"on_hint_enter_area",[node,tx_code,true])
	node.connect("mouse_exited",self,"on_hint_enter_area",[node,tx_code,false])

func on_hint_enter_area(node,code,val):
	if val:
		hint_current_node = node
		GAME.get_node("CanvasLayerUI/HintPanel/Label").text = Lang.get_text(code)
		GAME.get_node("CanvasLayerUI/HintPanel/RichTextLabel").bbcode_text = Lang.get_text(code)
		GAME.get_node("CanvasLayerUI/HintPanel").visible = true
	elif hint_current_node == node:
		GAME.get_node("CanvasLayerUI/HintPanel").visible = false

