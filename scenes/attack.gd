extends State

func process_physics(delta: float) -> State:
	parent.velocity.x = 0
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	parent.move_and_slide()
	
	return null
