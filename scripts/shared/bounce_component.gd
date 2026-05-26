class_name BounceComponent
extends Node

@export var BOUNCE_VELOCITY: float = 200
@export var BOUNCE_CUTOFF: float = 25
@export var BOUNCE_FALLOFF: float = 4
var currentBounceVelocity = 0

func apply(parent: CharacterBody2D) -> void:
	if parent.is_on_floor() && currentBounceVelocity > BOUNCE_CUTOFF:
		parent.velocity.y -= currentBounceVelocity
		currentBounceVelocity /= BOUNCE_FALLOFF
		return
	
	if currentBounceVelocity == 0:
		currentBounceVelocity += BOUNCE_VELOCITY


		
	currentBounceVelocity = 0
