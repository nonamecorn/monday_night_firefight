extends  CharacterBody2D

@onready var gun = $hand
signal died

enum {
	MOVE,
	IDLE,
}

var state = IDLE
var health = 10

func _physics_process(delta):
	match state:
			MOVE:
				move_state(delta)


const MAX_SPEED = 120
const ACCELERATION = 500
const FRICTION = 500
func get_input_dir():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

func move_state(delta):
	var input_vector = get_input_dir()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED,delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	move_and_slide()

func play():
#	$hand.state = 0
	state = MOVE
	$Camera2D.enabled = true

func death():
	state = IDLE
	$CollisionShape2D.disabled = true

func hurt():
	health -= 1
	print(health)
	if health == 0:
		emit_signal("died")
		call_deferred("death")




