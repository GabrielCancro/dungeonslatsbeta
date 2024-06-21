extends Control

var room_node
var rooms = {} #room_x_y
var doors = [] #{tileA:(x,y) tileB:(x,y)}
var last_nodes = []
var new_nodes = []
var rooms_amount = 10
var fails = 0
var percent_of_door = 30

# Called when the node enters the scene tree for the first time.
func generate_new_map(_rooms_amount,generate_by_steps=false):
	rooms_amount = _rooms_amount
	randomize()
	create_new_room(0,0)
	if generate_by_steps: return rooms
	while rooms_amount>0 && fails<30 && new_nodes.size()>0: next_step_generation()
	remove_unconnected_doors()
	return rooms

func clear_map():
	rooms = {}
	last_nodes = []
	new_nodes = []

func next_step_generation():
	last_nodes = new_nodes
	#if rooms_amount>0 && last_nodes.size()==0: add_one_random_door()
	#if rooms_amount<=0: remove_unconnected_doors()
	new_nodes = []
	for r in last_nodes:
		var room_data = rooms[r]
		room_data.is_creted_in_last_step = false
		if room_data.doors.up: create_new_room(room_data.posX,room_data.posY-1)
		if room_data.doors.down: create_new_room(room_data.posX,room_data.posY+1)
		if room_data.doors.left: create_new_room(room_data.posX-1,room_data.posY)
		if room_data.doors.right: create_new_room(room_data.posX+1,room_data.posY)

func create_new_room(x,y):
	fails += 1
	var room_name = "room_"+str(x)+"_"+str(y)
	if room_name in rooms: return
	if rooms_amount<=0: return
	rooms_amount -= 1
	fails = 0
	new_nodes.append(room_name)
	var room_data = {
		"name": room_name,
		"posX":x,
		"posY":y,
		"doors":{"up":null,"down":null,"left":null,"right":null},
		"is_creted_in_last_step":true,
		"is_explored":false,
		"node_ref":null,
		"state":"unexplored", #unexplored, ask, danger, safe
		"defiances": DefianceManager.get_room_random_defiances(),
		"items": ItemManager.get_some_items()
	}
	if (x==0 && y==0):
		room_data.doors["up"] = create_one_door(x,y,x+0,y-1)
		room_data.doors["down"] = create_one_door(x,y,x+0,y+1)
		room_data.doors["left"] = create_one_door(x,y,x-1,y+0)
		room_data.doors["right"] = create_one_door(x,y,x+1,y+0)
	else:
		create_random_doors(room_data,x,y)
	
	rooms["room_"+str(x)+"_"+str(y)] = room_data
	#var string = "->"+room_data.name
	#for d in room_data.doors.keys(): if room_data.doors[d]: string+=" "+d
	#print(string)

func create_random_doors(room_data,x,y):
	var r = get_room_data(x,y-1)
	if r && r.doors["down"]: room_data.doors["up"] = r.doors["down"]
	r = get_room_data(x,y+1)
	if r && r.doors["up"]: room_data.doors["down"] = r.doors["up"]
	r = get_room_data(x+1,y)
	if r && r.doors["left"]: room_data.doors["right"] = r.doors["left"]
	r = get_room_data(x-1,y)
	if r && r.doors["right"]: room_data.doors["left"] = r.doors["right"]
	
	if(!room_data.doors["up"] && randi()%100<percent_of_door): room_data.doors["up"] = create_one_door(x,y,x+0,y-1)
	if(!room_data.doors["down"] && randi()%100<percent_of_door): room_data.doors["down"] = create_one_door(x,y,x+0,y+1)
	if(!room_data.doors["left"] && randi()%100<percent_of_door): room_data.doors["left"] = create_one_door(x,y,x-1,y+0)
	if(!room_data.doors["right"] && randi()%100<percent_of_door): room_data.doors["right"] = create_one_door(x,y,x+1,y+0)

func create_one_door(x,y,toX,toY):
	var door_data = {"tileA":Vector2(x,y),"tileB":Vector2(toX,toY),"door_ref":null}
	doors.append(door_data)
	return door_data

func remove_unconnected_doors():
	var to_remove = []
	for door_data in doors:
		if !get_room_data(door_data.tileA.x,door_data.tileA.y) || !get_room_data(door_data.tileB.x,door_data.tileB.y):
			print("REMOVED DOOR ",door_data)
			to_remove.append(door_data)
	for door_data in to_remove: 
		doors.erase(door_data)
		
func get_room_data(x,y):
	if "room_"+str(x)+"_"+str(y) in rooms:
		return rooms["room_"+str(x)+"_"+str(y)]
	else:
		return null
