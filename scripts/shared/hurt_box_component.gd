class_name HurtBoxComponent
extends Node

@export var hurtArea: Area2D
@export var damage: int = 1

@onready var timer: Timer = $Timer

var playerInHurtArea: bool = false

func _ready() -> void:
	if hurtArea:
		hurtArea.body_entered.connect(_playerEntered)
		
func _playerEntered(body: Node2D) -> void:
	if !(body.name == "Player" and body.alive):
		return
