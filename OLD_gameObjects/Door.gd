extends Node2D

var door_data

func set_data(_data):
	door_data = _data
	if door_data.tileB.x-door_data.tileA.x == 0: $SpriteH.visible = false
	else: $SpriteV.visible = false
	$Button.connect("button_down",self,"on_click_door")

func on_click_door():
	var pdata = PlayerManager.get_player_data()
	var dir = Vector2(pdata.posX,pdata.posY)
	if door_data.tileA==dir: dir = door_data.tileB-dir
	else: dir = door_data.tileA-dir
	PlayerManager.move_player_to(dir)
