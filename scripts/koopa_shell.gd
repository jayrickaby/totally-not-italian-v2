extends EnemyBase

const Directions = BasicMoveComponent.Directions

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var kickable_component: KickableComponent = $KickableComponent
@onready var stompable_component: StompableComponent = $StompableComponent

@export var initiallySpinning: Directions = Directions.NONE
var isSpinning: bool = false

func _ready() -> void:
	basic_move_component.setDirection(initiallySpinning)
	#kickable_component.kicked.connect(_kick)
	#stompable_component.stomped_by_player.connect(_stomp)
	
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
		
func _kick(kickedFrom: Directions) -> void:
	if !alive or isSpinning:
		return
	
	if (kickedFrom == Directions.RIGHT):
		_spin(Directions.LEFT)
	else:
		_spin(Directions.RIGHT)
				
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
	


func _on_kick_area_body_entered(body: Node2D) -> void:
	if body.name != "Player" or body.alive == false:
		return
	
	var kickDir: Directions = Directions.NONE
	
	if body.global_position.x < global_position.x:
		kickDir = Directions.RIGHT
	elif body.global_position.x > global_position.x:
		kickDir = Directions.LEFT
	
	if isSpinning and !body.is_on_floor():
		_stomp(body)
	elif !isSpinning and body.is_on_floor():
		_kick(kickDir)
	elif !isSpinning and !body.is_on_floor():
		_stomp(body)
		_kick(kickDir)
	
