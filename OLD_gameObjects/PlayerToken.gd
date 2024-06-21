extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func set_data(player_data):
	$Sprite.texture = load("res://assets/retraits/token_retrait"+str(player_data.retrait)+".png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
