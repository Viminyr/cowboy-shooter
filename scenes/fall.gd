extends State

func process_physics(delta: float) -> State:
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	
	if parent.direction:
			parent.velocity.x = move_toward(parent.velocity.x, 
			parent.direction * parent.move_speed, 
			parent.acceleration * delta / parent.air_accel
			)
	else:
		parent.velocity.x + move_toward(parent.velocity.x, 0, 50 * delta)
	
	parent.move_and_slide()

	if parent.is_on_floor():
		if parent.direction:
			return states.move
		else:
			return states.idle
	
	return null

func process_input(_input : InputEvent) -> State:
	if parent.ammo > 0:
		if Input.is_action_pressed("shoot"):
			return states.shoot
	else:
		if Input.is_action_just_pressed("shoot"):
			return states.shoot
	
	return null
