extends Control

var type
var isValid = false

func set_slat(_type):
	type = _type
	$TextureRect.texture = load("res://assets/slats/"+type+".png")
	modulate.a = 0

func _ready():
	randomize()
	roll()

func roll():
	if type == "EN": set_valid(true)
	else: set_valid( randi()%100 < 50 )

func set_valid(val):
	isValid = val
	if isValid: modulate = Color(1,1,1,1)
	else: modulate = Color(.4,.4,.4,1)

func goto_pos(end_pos):
	$Tween.interpolate_property(self,"rect_position",rect_position,end_pos,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property(self,"modulate:a",0,1,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func consume():
	isValid = false
	$Tween.interpolate_property(self,"rect_global_position",rect_global_position,rect_global_position+Vector2(0,-100),.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property(self,"modulate:a",1,0,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	get_parent().remove_child(self)
	queue_free()
