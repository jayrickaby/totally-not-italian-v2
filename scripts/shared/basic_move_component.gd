class_name BasicMoveComponent
extends Node

enum Directions {
	LEFT = -1, 
	NONE = 0,
	RIGHT = 1 
}

@export var initialDirection: Directions = Directions.RIGHT
@export var flipOnWall: bool = false
@export var gravityScale: float = 1
@export var speed: float = 100
var direction: int

signal direction_changed

func _ready() -> void:
	setDirection(initialDirection)

func tick(parent: CharacterBody2D, delta: float) -> void:
	# X DIRECTION
	if parent.is_on_wall() && flipOnWall:
		flipDirection()

	if direction:
		parent.velocity.x = direction * speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, speed)

	# Y DIRECTION
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * gravityScale * delta

	parent.move_and_slide()
		
		
func setDirection(newDirection: Directions) -> void:
	direction = newDirection
	direction_changed.emit(direction)
	
func flipDirection() -> void:
	direction *= -1
	direction_changed.emit(direction)
