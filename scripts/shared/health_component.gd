class_name HealthComponent
extends Node

enum HealthStates {
	Alive,
	Dead
}

@export var health: int = 1
@export var initialState: HealthStates = HealthStates.Alive

var state: HealthStates

signal damaged(amount: int)
signal died()

func _ready() -> void:
	state = initialState

func damage(amount: int) -> void:
	health -= amount
	damaged.emit(amount)
	
	if health <= 0:
		state = HealthStates.Dead
		died.emit()
