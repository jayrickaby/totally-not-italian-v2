extends CharacterBody2D

var direction = 0
@onready var bounce_component: BounceComponent = $BounceComponent

@export var id: String = ""

static var keyIds = []

signal collected_by_player

func _ready() -> void:
	if !get_parent().name == "Keys":
		print("Key in invalid space!")
		call_deferred("destroy")
		
	if keyIds.has(id):
		print("Duplicate Key '" + id + "'")
		call_deferred("destroy")
	else:
		keyIds.append(id)
	
		

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	bounce_component.apply(self)
	


func _on_collect_area_entered(body: Node2D) -> void:
	if (body.name == "Player" && body.alive):
		emit_signal("collected_by_player", body, id)
		call_deferred("destroy")

func destroy() -> void:
	queue_free()
