class_name BasicMoveComponent
extends Node

enum Directions {LEFT, RIGHT, NONE}

@export var initialDirection: Directions = Directions.RIGHT
@export var flipOnWall: bool = 0
@export var gravityScale: float = 1
@export var speed: float = 100
var direction: int

signal direction_changed

func _ready() -> void:
	setDirection(initialDirection)

func tick(parent: CharacterBody2D, delta: float) -> void:
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * gravityScale * delta

	if direction:
		parent.velocity.x = direction * speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, speed)

	parent.move_and_slide()
	
	if parent.is_on_wall() && flipOnWall:
		direction *= -1
		emit_signal("direction_changed", direction)
		
func setDirection(newDirection: Directions) -> void:
	if newDirection == Directions.LEFT:
		direction = -1
	elif newDirection == Directions.RIGHT:
		direction = 1
	else:
		direction = 0
	
