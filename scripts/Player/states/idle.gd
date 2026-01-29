extends State


func process_physics(delta: float) -> State:
	parent.velocity.x = 0
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return states.fall
	
	if parent.direction:
		return states.move
	
	return null

func process_input(_input : InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor:
		return states.jump
	if Input.is_action_pressed("shoot"):
		return states.shoot
	return null
