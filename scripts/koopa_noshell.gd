extends EnemyBase

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent

func _physics_process(delta: float) -> void:
	if !alive:
		return
		
	basic_move_component.tick(self, delta)
