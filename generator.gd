extends Node2D

@onready var start = $startroom
var rooms = []
var did = false
func _ready():
	start.spawn_corr()

func spawn_at_random():
	print(main.room_count)
	rooms = []
	rooms = get_tree().get_nodes_in_group("room")
	for room in rooms:
		if !room.can_place:
			rooms.erase(room)
#	rooms.shuffle()
	print(rooms)
	if rooms[0].can_place:
		rooms[0].innit()
	else:
		spawn_at_random()

func done():
	print("done")
#	did = true
	rooms = get_tree().get_nodes_in_group("room")
	for room_ind in rooms:
		room_ind.call_deferred("shade") 
##	get_child(get_child_count() - 1).make_exit()
#	$Camera2D.enabled = false
#	$player.play()
