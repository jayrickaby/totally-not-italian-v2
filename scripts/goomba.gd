extends CharacterBody2D

@onready var goomba: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 20.0
var direction := -1


func _physics_process(delta: float) -> void:		
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "walk"
		animated_sprite_2d.flip_h = (direction == -1)
	else:
		animated_sprite_2d.animation = "idle"
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
