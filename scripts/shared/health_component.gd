class_name HealthComponent
extends Node

enum HealthStates {
	Alive,
	Dying,		# Still present but doesn't functionally exist (i.e. death animations)
	Dead
}

@export var health: int = 1
@export var initialState: HealthStates = HealthStates.Alive
@export var enabled: bool = true

var state: HealthStates

signal damaged(amount: int)
signal dying
signal died

func _ready() -> void:
	state = initialState

func damage(amount: int) -> void:
	if !enabled:
		return
		
	health -= amount
	damaged.emit(amount)
	
	if health <= 0:
		die()
	
func die() -> void:
	if !enabled:
		return
		
	if state == HealthStates.Dying: 
		# Don't want repeat of signal
		return
	
	state = HealthStates.Dying
	dying.emit()

func destroy() -> void:
	if !enabled:
		return
	
	if state == HealthStates.Dead:
		# Don't want repeat of signal
		return

	state = HealthStates.Dead
	health = 0
	died.emit()	
