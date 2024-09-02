extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(.1),"timeout")
	EffectManager.add_hint($Button,"tx_habiliti_name")

func set_data(_data):
	if !_data:
		visible = false
	else:
		$Label.text = _data

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
