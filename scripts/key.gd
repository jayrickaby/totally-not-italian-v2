extends CharacterBody2D

const BOUNCE_VELOCITY = -200
var currentBounceVelocity = 0
var direction = 0

@export var id: String = ""

signal collected_by_player

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	# Bounce Logic!!! RAGH
	if not is_on_floor() && currentBounceVelocity == 0:
		currentBounceVelocity = BOUNCE_VELOCITY
	elif is_on_floor() && currentBounceVelocity < -25:
		velocity.y += currentBounceVelocity
		currentBounceVelocity /= 3
	elif is_on_floor() && currentBounceVelocity >= -25:
		currentBounceVelocity = 0	

func _on_collect_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive):
		emit_signal("collected_by_player", body, id)
		call_deferred("destroy")

func destroy() -> void:
	queue_free()
