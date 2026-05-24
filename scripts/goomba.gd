extends CharacterBody2D

@onready var goomba: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_damaged
signal stomped_by_player

const SPEED = 20.0
var direction = -1
var alive = true;

func _physics_process(delta: float) -> void:	
	if !alive:
		return
			
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
	
	if is_on_wall():
		direction *= -1

func _on_hurt_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive && alive):
		emit_signal("player_damaged", body)

func _on_stomp_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive && !body.is_on_floor() && alive):
		stomp()
		emit_signal("stomped_by_player", body)
		
func stomp() -> void:
	alive = false;
	animated_sprite_2d.animation = "stomped"

func _on_animation_looped() -> void:
	if (animated_sprite_2d.animation == "stomped"):
		call_deferred("die")
	
func die() -> void:
	queue_free()
