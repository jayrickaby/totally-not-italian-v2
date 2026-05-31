class_name ShellBase
extends EnemyBase

const Directions = BasicMoveComponent.Directions

@export var basic_move_component: BasicMoveComponent
@export var initialSpinDirection: Directions = Directions.NONE
@export var kickArea: Area2D
@export var stompable_component: StompableComponent

# So that it doesn't kick while player is stopping shell
var playerInStompArea: bool = false

var isSpinning: bool = false

func _ready() -> void:
	if kickArea:
		kickArea.body_entered.connect(_on_kick_area_entered)
		
	if stompable_component:
		stompable_component.stomped_by_player.connect(_enterStomp)
		stompable_component.player_stopped_stomping.connect(_exitStomp)
		
func _on_kick_area_entered(body: Node2D) -> void:
	if !(body.name == "Player" and body.alive):
		return
		
	if playerInStompArea and !isSpinning:
		return
	
	call_deferred("_kick", body)
	
func _kick(player: Node2D) -> void:	
	var kickTo: Directions = Directions.NONE
	
	if player.global_position.x < global_position.x:
		kickTo = Directions.RIGHT
	elif player.global_position.x > global_position.x:
		kickTo = Directions.LEFT
	
	_spin(kickTo)
	
func _spin(spinTo: Directions) -> void:	
	if basic_move_component:
		basic_move_component.setDirection(spinTo)
		
	if spinTo != Directions.NONE:
		isSpinning = true  
	else: 
		isSpinning = false
		
func _stomp(player: Node2D) -> void:
	if !(player.name == "Player" and player.alive):
		return
		
	player.initiateJump()
	
	if isSpinning:
		_spin(Directions.NONE)
	else:
		_kick(player)
	
	
func _enterStomp(body: Node2D) -> void:
	_stomp(body)
	playerInStompArea = true
	
func _exitStomp(_body: Node2D) -> void:
	playerInStompArea = false
		
