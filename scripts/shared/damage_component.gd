class_name DamageComponent
extends Node

@export var damageArea: Area2D
@export var damage: int = 1
@export var disabled: bool = false

var playerInDamageArea: bool = false

func _ready() -> void:
	if damageArea:
		damageArea.body_entered.connect(_on_damage_area_entered)
		
func _on_damage_area_entered(body: Node2D) -> void:
	if !(body.name == "Player" and body.alive):
		return
		
	if disabled:
		return
	# playerInDamageArea = true
		
	_damage(body)
		
func _damage(body: Node2D) -> void:
	
	# TODO Replace with HealthComponent
	body.damage(damage)
	 
