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
	basic_move_component.tick(self, delta)
	
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "spin"
	else:
		animated_sprite_2d.animation = "idle"
		
func _on_interaction_area_entered(body: Node2D) -> void:
	if !(body.name == "Player" and body.alive) or isSpinning:
		return
	
	# Kick - prefer right when center
	if body.global_position.x <= global_position.x:
		_startSpinning(Directions.RIGHT)
	elif body.global_position.x >= global_position.x:
		_startSpinning(Directions.LEFT)
		
func _startSpinning(spinDirection: Directions) -> void:
	basic_move_component.setDirection(spinDirection)
	isSpinning = true
	
func _stomp(player: Node2D) -> void:
	if !alive:
		return
		
	player.initiateJump()
