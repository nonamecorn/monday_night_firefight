extends Node2D


var flipped = false

func _process(_delta):
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	if look_vec.x < 0 and !flipped:
		flip()
	if look_vec.x >= 0 and flipped:
		flip()
	
func flip():
	flipped = !flipped
	scale.y *= -1




