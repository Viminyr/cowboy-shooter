extends Area2D

@onready var timer: Timer = $Timer

var lifetime: float = 0.5
var speed: int = 300
var direction: int = 1
var damage: int = 1

func _ready() -> void:
	timer.start(lifetime)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("update_health"):
		body.update_health(-damage, self)
	queue_free()
	
func _process(delta: float) -> void:
	position.x += speed * direction * delta

func _on_timer_timeout() -> void:
	queue_free()
