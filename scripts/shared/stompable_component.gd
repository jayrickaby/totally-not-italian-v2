extends Node

@export var stompArea: Area2D

signal stomped_by_player

func _ready() -> void:
	if stompArea:
		stompArea.body_entered.connect(_on_stomp_area_entered)
		
func _on_stomp_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && !body.is_on_floor()):
		emit_signal("stomped_by_player")
