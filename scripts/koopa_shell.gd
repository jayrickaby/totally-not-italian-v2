extends ShellBase
	
func _physics_process(delta: float) -> void:
	if !alive:
		return
		
	basic_move_component.tick(self, delta)
	
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "spin"
	else:
		animated_sprite_2d.animation = "idle"
