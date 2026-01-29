extends State

func enter() -> void:
	super()
	animation.connect("animation_finished", _on_animation_finished)
	parent.sound.play("Death")

func _on_animation_finished(anim_name: StringName) -> void:
	parent.queue_free()
 
