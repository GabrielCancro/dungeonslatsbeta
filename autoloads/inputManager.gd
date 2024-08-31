extends Node

var InputStopperNode
var time = 0

func _initialize_input_manager(input_stopper_node):
	InputStopperNode = input_stopper_node
	InputStopperNode.visible = false

func _ready():
	set_process(false)
	pass

func _process(delta):
	time -= delta
	if time<=0:
		time = 0
		InputStopperNode.visible = false
		set_process(false)

func disable_input(_time):
	if time<_time: time = _time
	if time>0:
		InputStopperNode.visible = true
		set_process(true)
