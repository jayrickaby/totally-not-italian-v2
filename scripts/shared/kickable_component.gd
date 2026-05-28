class_name KickableComponent
extends Node

const Directions = BasicMoveComponent.Directions

@export var kickArea: Area2D

signal kicked(direction: Directions)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if kickArea:
		kickArea.body_entered.connect(_on_kick_area_entered)

func _on_kick_area_entered(body: Node2D) -> void:
	if !(body.name == "Player" and body.alive):
		return
	
	var dir: Directions = Directions.NONE
	var parent: CharacterBody2D = get_parent()
	
	# The side where parent was kicked from
	if body.global_position.x < parent.global_position.x:
		dir = Directions.LEFT
	elif body.global_position.x > parent.global_position.x:
		dir = Directions.RIGHT
	
	kicked.emit(dir)
