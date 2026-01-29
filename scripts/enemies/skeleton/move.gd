extends State

func process_physics(delta: float) -> State:
	parent.velocity.x = parent.move_speed * parent.direction
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	parent.move_and_slide()
	
	return null

func process_frame(delta: float) -> State:
	if !parent.direction:
		return states.Idle
	if parent.wants_attack:
		return states.Attack
	if parent.sprite.frame == 16 and !parent.sound.playing:
		parent.sound.play("Footstep")
	
	return null
