extends CharacterBody2D


const SPEED = 4.0
const JUMP_VELOCITY = -400.0

var direction = 1

signal player_damaged
signal stomped_by_player

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
