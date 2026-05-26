extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var stompable_component: StompableComponent = $StompableComponent

signal damage_to_player	

func _ready() -> void:
	basic_move_component.direction_changed.connect(_change_direction)
	stompable_component.stomped_by_player

func _physics_process(delta: float) -> void:
	basic_move_component.tick(self, delta)

func _change_direction(direction: int) -> void:
	animated_sprite_2d.flip_h = (direction == -1)
