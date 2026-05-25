extends CharacterBody2D
@onready var basic_move_component: Node = $BasicMoveComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_damaged
signal stomped_by_player

func _ready() -> void:
	basic_move_component.direction_changed.connect(_change_direction)

func _physics_process(delta: float) -> void:
	basic_move_component.tick(self, delta)

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)
