extends CharacterBody2D

const MAX_SPEED = 110
const ACCELERATION = 700
const FRICTION = 700

var health = 3
var current_target = null
var dead = false
enum {
	CHASE,
	IDLE
}
var state = IDLE
var rng = RandomNumberGenerator.new()

@onready var nav_agent = $NavigationAgent2D
func _ready():
	global_rotation = 0
	rng.randomize()#currently useless


func set_movement_target(target_point: Vector2):
	nav_agent.target_position = target_point

func _physics_process(delta):
	if dead or nav_agent.is_navigation_finished():
		return
	if current_target != null:
		$RayCast2D.set_target_position(current_target.global_position)
	
	match state:
		CHASE:
			move(delta)

func move(delta):
	var next_path = nav_agent.get_next_path_position()
	var new_velocity = (next_path - global_position).normalized()
	velocity = velocity.move_toward(new_velocity * MAX_SPEED,delta * ACCELERATION)
	move_and_slide()


func _on_makepath_timeout():
	if !dead:
		set_movement_target(current_target.position)
	
func fucking_shit():
	state = IDLE
	current_target = null
	$makepath.stop()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and !dead:
		if current_target == null:
			body.died.connect(fucking_shit)
#		print("tried")
		current_target = body
	#	$AnimationPlayer.play("walk1")
		$makepath.start()
		state = CHASE
		set_movement_target(body.position)

func hurt():
	health -= 1
	if health == 0:
		call_deferred("die")

func die():
	$Sprite2D.frame = 4
	dead = true
	state = IDLE
	$CollisionShape2D.disabled = true

func _on_hurtbox_body_entered(body):
	if body.is_in_group("player") and !dead:
		body.hurt()
		$attack.start()
func _on_hurtbox_body_exited(body):
	if body.is_in_group("player") and !dead:
		$attack.stop()
func _on_attack_timeout():
	if !dead:
		current_target.hurt()

