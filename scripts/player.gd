extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var snd_jump: AudioStreamPlayer2D = $snd_jump

const SPEED = 50.0
const JUMP_VELOCITY = -250.0
var keys = []

var alive = true;

func _physics_process(delta: float) -> void:
	if !alive:
		return
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	
	# Add animation
	if not is_on_floor():
		animated_sprite_2d.animation = "jump"
	elif velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "walk"
		animated_sprite_2d.flip_h = (direction == -1)
	else:
		animated_sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and  is_on_floor():
		velocity.y = JUMP_VELOCITY	
		snd_jump.play()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func die() -> void:
	alive = false;
	queue_free()
