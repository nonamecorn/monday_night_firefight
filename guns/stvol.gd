extends Marker2D


func get_bullet_spawn_position():
	if get_child_count() == 0:
		return global_position
	else:
		return get_child(0).get_child(0).global_position
