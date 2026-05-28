extends EnemyBase

const Directions = BasicMoveComponent.Directions

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var stompable_component: StompableComponent = $StompableComponent

@export var initiallySpinning: Directions = Directions.NONE
var isSpinning: bool = false

func _ready() -> void:
	basic_move_component.setDirection(initiallySpinning)
	stompable_component.stomped_by_player.connect(_stomp)
	
	if initiallySpinning != Directions.NONE:
		isSpinning = true
 
func _physics_process(delta: float) -> void:
	if !alive:
		return
		
	basic_move_component.tick(self, delta)
	
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "spin"
	else:
		animated_sprite_2d.animation = "idle"
		
func _on_interaction_area_entered(body: Node2D) -> void:
	if !alive:
		return
		
	if !body.name == "Player" or !body.alive:
		return
		
	if isSpinning:
		return
	
	# Kick - prefer right when center
	if body.global_position.x <= global_position.x:
		_spin(Directions.RIGHT)
	elif body.global_position.x >= global_position.x:
		_spin(Directions.LEFT)
		
func _spin(spinDirection: Directions) -> void:
	basic_move_component.setDirection(spinDirection)
	if spinDirection != Directions.NONE:
		isSpinning = true
	else:
		isSpinning = false
	
func _stomp(player: Node2D) -> void:
	if !alive:
		return
		
	if isSpinning:
		_spin(Directions.NONE)
		
	player.initiateJump()
