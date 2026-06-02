extends ShellBase

@onready var damage_component: DamageComponent = $DamageComponent

func _physics_process(delta: float) -> void:
	if !alive:
		return
		
	basic_move_component.tick(self, delta)
	
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "spin"
	else:
		animated_sprite_2d.animation = "idle"
		
	if !isSpinning:
		damage_component.disabled = true
	else:
		damage_component.disabled = false
