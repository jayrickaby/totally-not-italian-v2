extends Node2D

@export var linkKeyId: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_detection_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive && body.keys.has(linkKeyId)):
		call_deferred("destroy")
		
func destroy():
	queue_free()
