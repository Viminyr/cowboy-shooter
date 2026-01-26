extends Area2D

class_name hitbox

@export_enum("Player", "Enemy") var hitbox_owner
@export var position_flippable : Vector2

var direction

func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	pass
