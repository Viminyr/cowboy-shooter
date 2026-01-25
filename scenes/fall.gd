extends State

@export var idle_state : State
@export var move_state : State
@export var jump_state : State
@export var shoot_state : State

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
			return move_state
		else:
			return idle_state
	
	return null

func process_input(input : InputEvent) -> State:
	if parent.ammo > 0:
		if Input.is_action_pressed("shoot"):
			return shoot_state
	else:
		if Input.is_action_just_pressed("shoot"):
			return shoot_state
	
	return null
