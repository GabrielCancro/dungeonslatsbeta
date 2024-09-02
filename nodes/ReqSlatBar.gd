extends HBoxContainer

func _ready():
	visible = false

func set_data(req):
	visible = true
	var rq_array = []
	for k in req.keys(): for i in range(req[k]): rq_array.append(k)
	for tx in get_children():
		tx.visible = rq_array.size()>0
		if tx.visible: tx.texture = load("res://assets/slats/"+rq_array.pop_front()+".png")
