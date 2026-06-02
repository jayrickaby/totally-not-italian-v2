class_name DamageComponent
extends Node

@export var hitbox: Area2D
@export var damage: int = 1
@export var disabled: bool = false

func _ready() -> void:
	if hitbox:
		hitbox.body_entered.connect(_on_hitbox_entered)
		
func _on_hitbox_entered(player: Player) -> void:
	if !(player.isAlive()):
		return
		
	if disabled:
		return
		
	_damage(player)
		
func _damage(player: Player) -> void:
	if player.health_component:
		player.health_component.damage(damage)
		 
