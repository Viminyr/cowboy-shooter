extends State

@export var idle_state : State
@export var fall_state : State
@export var jump_state : State
@export var shoot_state : State

func process_physics(delta : float) -> State:
	parent.velocity.x = move_toward(parent.velocity.x, parent.direction * parent.move_speed, parent.acceleration * delta)
	
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	
	if !parent.direction:
		return idle_state
	
	return null

func process_input(input : InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor:
		return jump_state
	if Input.is_action_just_pressed("shoot"):
		return shoot_state
	
	return null
