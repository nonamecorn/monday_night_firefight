extends CharacterBody2D

var speed = 250
var move_vec : Vector2
var mod_vec : Vector2

func _ready():
	init()

func init():
	move_vec = Vector2.RIGHT
	move_vec = move_vec.rotated(global_rotation)


func hit_body(body: PhysicsBody2D):
	if is_instance_valid(body) and body.has_method("hurt"):
		deal_damage(body)

func _physics_process(delta):
	var coll = move_and_collide(move_vec * speed * delta)
	if coll:
		destroy_bullet()
		if coll.get_collider().has_method("hurt"):
			deal_damage(coll.get_collider())
		else:
			destroy_bullet()

func deal_damage(body):
	body.hurt()
	destroy_bullet()

func destroy_bullet():
	queue_free()



func _on_timer_timeout():
	destroy_bullet()
