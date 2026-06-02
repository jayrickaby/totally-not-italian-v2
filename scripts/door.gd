extends Node2D

@export var linkKeyId: String = ""

func _on_detection_area_entered(player: Player) -> void:
	if (player.isAlive() && player.keys.has(linkKeyId)):
		call_deferred("_destroy")
		
func _destroy():
	queue_free()
