extends EnemyBase

@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var stompable_component: StompableComponent = $StompableComponent
const KOOPA_SHELL = preload("uid://d2sw6xuqquagv")

func _ready() -> void:
	super()
	
	basic_move_component.direction_changed.connect(_change_direction)
	stompable_component.stomped_by_player.connect(_stomp)

func _physics_process(delta: float) -> void:
	if !alive:
		return
		
	basic_move_component.tick(self, delta)

func _stomp(player: Node2D) -> void:
	if !alive:
		return
		
	alive = false
	player.initiateJump()
	call_deferred("_createShell")
	call_deferred("_die")
	
func _createShell() -> void:
	var ShellNode = KOOPA_SHELL.instantiate()
	add_sibling(ShellNode)
	ShellNode.global_position = global_position
	ShellNode.playerInStompArea = true

	
	
