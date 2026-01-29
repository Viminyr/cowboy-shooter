extends State

var animation_done = false

func enter() -> void:
	if !animation.get_signal_connection_list("animation_finished"):
		animation.connect("animation_finished", _on_animation_finished)
	animation_done = false
	super()
	parent.shoot()

func process_physics(delta : float) -> State:
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	parent.velocity.x = 0
	
	parent.move_and_slide()
	
	if animation_done:
		if parent.direction:
			return states.Move
		elif parent.wants_attack:
			return states.Shoot
		return states.Idle
	return null

func _on_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(0.5).timeout
	animation_done = true
