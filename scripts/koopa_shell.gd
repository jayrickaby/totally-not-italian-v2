extends CharacterBody2D

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@export var initiallySpinning: BasicMoveComponent.Directions = BasicMoveComponent.Directions.NONE
var isSpinning: bool = false

signal damage_to_player

func _ready() -> void:
	basic_move_component.setDirection(initiallySpinning)
	if initiallySpinning != BasicMoveComponent.Directions.NONE:
		isSpinning = true
 
func _physics_process(delta: float) -> void:
	basic_move_component.tick(self, delta)

func _on_hurt_area_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive and isSpinning:
		damage_to_player.emit(body)
		
		
func _on_interaction_area_entered(body: Node2D) -> void:
	if !(body.name == "Player" and body.alive) or isSpinning:
		return
