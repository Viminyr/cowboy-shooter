extends State

@export var fall_state : State
@export var shoot_state : State

func enter() -> void:
	super()
	parent.velocity.y = parent.jump_velocity
	parent.sound.play("Jump")

func process_physics(delta : float) -> State:
	parent.velocity.y += parent.gravity * delta
	
	if parent.direction:
			parent.velocity.x = move_toward(parent.velocity.x, 
			parent.direction * parent.move_speed, 
			parent.acceleration * delta / parent.air_accel
			)
	else:
		parent.velocity.x + move_toward(parent.velocity.x, 0, 50 * delta)
	
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall_state
	
	return null

func process_input(input : InputEvent) -> State:
	if parent.ammo > 0:
		if Input.is_action_pressed("shoot"):
			return shoot_state
	else:
		if Input.is_action_just_pressed("shoot"):
			return shoot_state
	
	return null
