extends Node2D

var rng = RandomNumberGenerator.new()
var conindexes = [1,2,3]
var can_place = true
var disabled = true

@export var frame_time = 10
@export var enabled = true
signal failed_to_place_self


func _ready():
	if !enabled:
		return
	align()
#	print($check.)
	
	rng.randomize()
	for connector in $connectors.get_children():
		if connector.get_index() != 0:
			connector.failed_to_spawn.connect(spawning_error.bind(connector.get_index()))
	disabled = false

func _physics_process(_delta):
	if disabled:
		return
	if frame_time != 0:
		frame_time -= 1
	else:
		check()

func _on_check_area_entered(_area):
	pass
#	print(area)
#	if !area.is_in_group("grey"):
#		call_deferred("retreat")
#	else:
#		get_parent().spawn_at_random()
#		$check.set_deferred("monitoring",false) 
#		$NavigationRegion2D.enabled = true
#		disabled = true

func check():
	if $check.has_overlapping_areas():
		print("cant place")
		call_deferred("retreat")
	else:
		print("can place")
		get_parent().spawn_at_random()
		$check.set_deferred("monitoring",false) 
		$NavigationRegion2D.enabled = true
		disabled = true

func retreat():
	emit_signal("failed_to_place_self")
#	get_parent().spawn_at_random()
	queue_free()

func align():
	global_position += (global_position - $connectors/connector.global_position)*2

func shade():
	var con = [$connectors/connector2,$connectors/connector3,$connectors/connector4]
	for child in con:
		if !child.has_path:
			child.close()
func innit():
	print("innited",disabled,can_place,conindexes)
	spawn_corr()
#	$spawn_timer.start()

func make_exit():
	$exit.show()
	$exit/Area2D.monitoring = true
#	$ColorRect.show()

func spawn_corr():
	print("spawnin' corr")
	if main.room_count < 10:
		if len(conindexes) == 0:
			print("all_paths_blocked")
			can_place = false
			get_parent().spawn_at_random()
			return
		main.room_count += 1
		conindexes.shuffle()
		var rnum = conindexes[0]
		$connectors.get_child(rnum).call_deferred("spawn_exact","res://rooms/basiccorridor.tscn")
		conindexes.pop_front()
	else:
		if !get_parent().did:
			make_exit()
			get_parent().done()



func spawning_error(connector_index):
	print("spawning error")
	$connectors.get_child(connector_index).call_deferred("close")
	conindexes.erase(connector_index)
	if len(conindexes) == 0:
		print("all_paths_blocked but fro spawning error")
#		can_place = false
	main.room_count -= 1
	get_parent().spawn_at_random()




