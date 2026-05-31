extends Node2D

func _ready() -> void:
	_setup_level()

func _setup_level() -> void:
	var enemies = $level.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.damage_to_player.connect(_on_player_damaged)
			
	var keys = $level.get_node_or_null("Keys")#
	if keys:
		for key in keys.get_children():
			key.collected_by_player.connect(_key_collected_by_player)
			
func _on_player_damaged(body) -> void:
	print("recieved player damage signal")
	body._die()

func _key_collected_by_player(body,id) -> void:
	body.keys.append(id)
	print(id)
