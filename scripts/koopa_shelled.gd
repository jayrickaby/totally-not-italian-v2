extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var stompable_component: StompableComponent = $StompableComponent

signal damage_to_player	

var alive = true

func _ready() -> void:
	basic_move_component.direction_changed.connect(_change_direction)
	stompable_component.stomped_by_player.connect(_stomp)

func _physics_process(delta: float) -> void:
	if !alive:
		return
		
	basic_move_component.tick(self, delta)

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)

func _stomp() -> void:
	alive = false
	call_deferred("die")

func die() -> void:
	queue_free()
