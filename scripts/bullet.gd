extends Area2D

var speed = 300
var direction = 1

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
func _process(delta: float) -> void:
	position.x += speed * direction * delta
