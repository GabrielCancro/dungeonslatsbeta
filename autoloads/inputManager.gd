extends Node

var InputStopperNode
var ClockSand
var time = 0

func _initialize_input_manager(input_stopper_node):
	InputStopperNode = input_stopper_node
	InputStopperNode.visible = false
	ClockSand = InputStopperNode.get_node("ClockSand")

func _ready():
	set_process(false)
	pass

func _process(delta):
	time -= delta
	#ClockSand.rect_global_position = get_viewport().get_mouse_position() - ClockSand.rect_size/2
	if time<=0:
		time = 0
		InputStopperNode.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		set_process(false)

func disable_input(_time):
	if time<_time: time = _time
	if time>0:
		InputStopperNode.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		set_process(true)
