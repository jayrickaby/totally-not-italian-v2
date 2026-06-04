extends EnemyBase

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var stompable_component: StompableComponent = $StompableComponent

const HealthStates = HealthComponent.HealthStates
var deathWaitForAnimation: bool = false

func _ready() -> void:	
	basic_move_component.direction_changed.connect(_change_direction)
	stompable_component.stomped_by_player.connect(_stomp)
	health_component.died.connect(_die)

func _physics_process(delta: float) -> void:	
	if health_component.state == HealthStates.Dead:
		return
	
	basic_move_component.tick(self, delta)
				
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "walk"
	else:
		animated_sprite_2d.animation = "idle"

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)
		
func _stomp(player: Node2D) -> void:
	if health_component.state == HealthStates.Dead:
		return
	
	deathWaitForAnimation = true
	animated_sprite_2d.animation = "stomped"
	player.initiateJump()
	health_component.die()

func _on_animation_looped() -> void:
	if (animated_sprite_2d.animation == "stomped"):
		deathWaitForAnimation = false
		call_deferred("_die")
		
func _die() -> void:
	if !deathWaitForAnimation:
		super()
		
