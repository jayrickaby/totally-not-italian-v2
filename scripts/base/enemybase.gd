class_name EnemyBase
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var hurt_area: Area2D

var alive: bool = true

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)

func _die() -> void:
	queue_free()
