extends Marker2D

signal failed_to_spawn

var has_path = false

#func _ready():
#	print(get_parent())

func  spawn_exact(module_path):
	var module = load(module_path)
	var module_inst = module.instantiate()
	module_inst.global_position = global_position
	module_inst.global_rotation = global_rotation
	module_inst.failed_to_place_self.connect(hesgone)
	
	get_tree().current_scene.add_child(module_inst)
	has_path = true

func close():
	has_path = false
	$Node2D.show()
	$Node2D/wall/CollisionShape2D.disabled = false

func hesgone():
	print("hesgone")
	emit_signal("failed_to_spawn")
