class_name EnemyBase
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var hurt_area: Area2D

signal damage_to_player

var alive: bool = true

func _ready() -> void:
	if hurt_area:
		hurt_area.body_entered.connect(_on_hurt_area_entered)

func _on_hurt_area_entered(body: Node2D) -> void:
	print("entered hurt area ", body.name, name)
	if body.name == "Player" and body.alive and alive:
		print("emitted player damage signal")
		damage_to_player.emit(body)

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)

func _die() -> void:
	queue_free()
