extends CharacterBody2D
@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent

signal damage_to_player

func _physics_process(delta: float) -> void:
	basic_move_component.tick(self, delta)
