extends Node

func remove_all_childs(parent_node):
	for c in parent_node.get_children():
		parent_node.remove_child(c)
		c.queue_free()

func repeated_string(_str,_rep):
	var res = ""
	for i in range(_rep): res += _str
	return res
