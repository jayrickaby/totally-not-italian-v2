extends CharacterBody2D

@onready var goomba: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var basic_move_component: Node = $BasicMoveComponent

signal player_damaged
signal stomped_by_player

var alive = true;

func _ready() -> void:
	basic_move_component.direction_changed.connect(_change_direction)

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
		emit_signal("player_damaged", body)

func _on_stomp_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive && !body.is_on_floor() && alive):
		stomp()
		emit_signal("stomped_by_player", body)
		
func stomp() -> void:
	alive = false;
	animated_sprite_2d.animation = "stomped"

func _on_animation_looped() -> void:
	if (animated_sprite_2d.animation == "stomped"):
		call_deferred("die")
	
func die() -> void:
	queue_free()
