extends ColorRect

var over_node = null
var ttl = 0

func _ready():
	set_over_node(null)

func set_over_node(node):
	over_node = node
	visible = false
	if over_node:
		visible = true
		rect_global_position = over_node.rect_global_position
		rect_size = over_node.rect_size

func _process(delta):
	ttl += delta*3
	for c in get_children(): c.color.a = abs(sin(ttl))*0.3 + 0.2
