class_name DamageComponent
extends Node

@export var hitbox: Area2D
@export var damage: int = 1
@export var enabled: bool = true

func _ready() -> void:
	if hitbox:
		hitbox.area_entered.connect(_on_hitbox_entered)
		
func _on_hitbox_entered(area: Area2D) -> void:				
	if !enabled:
		return
		
	var player: Player = area.get_parent()
		
	if !(player.isAlive()):
		return	
		
	_damage(player)
		
func _damage(player: Player) -> void:
	print("Damage from: ", get_parent(), " with: ", damage)
	if player.health_component:
		player.health_component.damage(damage)
		 
