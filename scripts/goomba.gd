extends EnemyBase

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var stompable_component: StompableComponent = $StompableComponent

func _ready() -> void:
	super()
	
	basic_move_component.direction_changed.connect(_change_direction)
	stompable_component.stomped_by_player.connect(_stomp)

func _physics_process(delta: float) -> void:	
	if !alive:
		return
	
	basic_move_component.tick(self, delta)
				
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "walk"
	else:
		animated_sprite_2d.animation = "idle"

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)
		
func _stomp(player: Node2D) -> void:
	if !alive:
		return
		
	alive = false;
	animated_sprite_2d.animation = "stomped"
	player.initiateJump()

func _on_animation_looped() -> void:
	if (animated_sprite_2d.animation == "stomped"):
		call_deferred("_die")
