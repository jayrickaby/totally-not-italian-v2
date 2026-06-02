class_name StompableComponent
extends Node

@export var stompArea: Area2D

signal stomped_by_player(player: Node2D)
signal player_stopped_stomping(player: Node2D)

# TODO Connect with health component and work in harmony
func _ready() -> void:
	if stompArea:
		stompArea.body_entered.connect(_on_stomp_area_entered)
		stompArea.body_exited.connect(_on_stomp_area_exited)
		
func _on_stomp_area_entered(player: Node2D) -> void:
	if !player.is_on_floor():
		stomped_by_player.emit(player)

func _on_stomp_area_exited(player: Node2D) -> void:
	if !player.is_on_floor():
		player_stopped_stomping.emit(player)
