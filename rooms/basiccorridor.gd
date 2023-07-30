extends Node2D

signal failed_to_place_self

func _ready():
	$connector2.failed_to_spawn.connect(place_failure)
	align()
	
	

func align():
	global_position -= (global_position - $connector.global_position)
	spawn_room()
	
#	pass
func spawn_room():
	$connector2.call_deferred("spawn_exact","res://rooms/basic_room.tscn")#rng goes here

func place_failure():
	print("im gone")
	get_parent().spawn_at_random()
	
	emit_signal("failed_to_place_self")
	queue_free()
