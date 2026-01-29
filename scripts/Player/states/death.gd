extends State

var source_self_position_difference: float

func enter() -> void:
	source_self_position_difference = parent.death_source.x - parent.position.x
	if source_self_position_difference * parent.facing_direction > 0:
		animation.play("Death_Backward")
	elif source_self_position_difference * parent.facing_direction < 0:
		animation.play("Death_Forward")
	else:
		super()
	parent.sound.play("Death")
	animation.connect("animation_finished", _on_animation_finished)
	if source_self_position_difference > 0:
		parent.velocity.x = -100
	else:
		parent.velocity.x = 100

func process_physics(delta: float) -> State:
	parent.velocity.x = move_toward(parent.velocity.x, 0, 100 * delta)
	
	parent.move_and_slide()
	return

func _on_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(1.0).timeout
	if get_tree():
		get_tree().reload_current_scene()
