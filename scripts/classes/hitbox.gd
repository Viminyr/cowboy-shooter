extends Area2D

class_name hitbox

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

@export_enum("Player", "Enemy") var hitbox_owner
@export var position_flippable : Vector2

var direction : int = 1
var damage : int = 1

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	
	collision_layer = 16
	if hitbox_owner:
		collision_mask = 2
	else:
		collision_mask = 4

func _process(delta: float) -> void:
	position = Vector2(position_flippable.x * direction, position_flippable.y)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("update_health"):
		body.update_health(-damage, self)
