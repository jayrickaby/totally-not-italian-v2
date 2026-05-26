extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var basic_move_component: BasicMoveComponent = $BasicMoveComponent
@onready var stompable_component: StompableComponent = $StompableComponent

signal damage_to_player

var alive = true;

func _ready() -> void:
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

func _on_hurt_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive && alive):
		emit_signal("damage_to_player", body)
		
func _stomp() -> void:
	alive = false;
	animated_sprite_2d.animation = "stomped"

func _on_animation_looped() -> void:
	if (animated_sprite_2d.animation == "stomped"):
		call_deferred("die")
	
func die() -> void:
	queue_free()
