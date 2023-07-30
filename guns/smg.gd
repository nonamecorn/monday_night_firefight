extends Node2D

var ammo = 30

var bullet_obj = preload("res://obj/bullet.tscn")
var continue_fire = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_left_mouse"):
		continue_fire = true
		$AnimationPlayer.play("fire")
	if Input.is_action_just_released("ui_left_mouse"):
		continue_fire = false


func repeat():
	if continue_fire:
		$AnimationPlayer.play("fire")

func fire():
	if ammo == 0:
		ammo = 30
#		$reload.start()
#		get_parent().state = 1
	if ammo > 0:
		ammo -= 1
		var bullet_inst = bullet_obj.instantiate()
		bullet_inst.global_position = $gun/stvol.get_bullet_spawn_position()
		bullet_inst.global_rotation = $gun.global_rotation
		bullet_inst.init()
		get_tree().current_scene.add_child(bullet_inst)

