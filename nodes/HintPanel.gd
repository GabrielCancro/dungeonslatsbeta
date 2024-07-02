extends ColorRect

func _ready(): visible = false

func show_hint(code,req=null):
	$Label.text = Lang.get_text(code)
	$RichTextLabel.bbcode_text = Lang.get_text(code)
	visible = true
	$HBox.visible = false
	if req:
		$HBox.visible = true
		print(req)
		var rq_array = []
		for k in req.keys(): for i in range(req[k]): rq_array.append(k)
		for tx in $HBox.get_children():
			tx.visible = rq_array.size()>0
			if tx.visible: tx.texture = load("res://assets/slats/"+rq_array.pop_front()+".png")

func hide_hint():
	visible = false
