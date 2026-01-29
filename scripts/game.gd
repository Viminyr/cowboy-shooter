extends Node2D

@onready var gui: CanvasLayer = $GUI
@onready var player: Player = $Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	player.connect("add_child_to_game_world", _add_child)
	player.connect("update_ammo_gauge", update_ammo_gauge)
	player.connect("update_health_gauge", update_health_gauge)
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		if enemy.has_signal("add_child_to_game_world"):
			enemy.connect("add_child_to_game_world", _add_child)

func update_ammo_gauge(ammo : int):
	gui.update_ammo_gauge(ammo)

func update_health_gauge(health : int):
	gui.update_health_gauge(health)

func _add_child(child) -> void:
	add_child(child)
