class_name BasicMoveComponent
extends Node

enum directions {LEFT, RIGHT}

@export var initialDirection: directions = directions.RIGHT
@export var flipOnWall: bool = 0
@export var gravityScale: float = 1
@export var speed: float = 100
var direction: int

signal direction_changed

func _ready() -> void:
	if initialDirection == directions.LEFT:
		direction = -1
	else:
		direction = 1

func tick(parent: CharacterBody2D, delta: float) -> void:
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * gravityScale * delta

	if direction:
		parent.velocity.x = direction * speed
	else:
		parent.velocity.x = parent.move_toward(parent.velocity.x, 0, speed)

	parent.move_and_slide()
	
	if parent.is_on_wall() && flipOnWall:
		direction *= -1
		emit_signal("direction_changed", direction)
