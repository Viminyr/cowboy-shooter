extends State

func process_physics(delta : float) -> State:
	parent.velocity.x = move_toward(parent.velocity.x, parent.direction * parent.move_speed, parent.acceleration * delta)
	
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return states.fall
	
	if !parent.direction:
		return states.idle
	
	return null

func process_input(_input : InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor:
		return states.jump
	if parent.ammo > 0:
		if Input.is_action_pressed("shoot"):
			return states.shoot
	else:
		if Input.is_action_just_pressed("shoot"):
			return states.shoot
	
	return null

func process_frame(_delta : float) -> State:
	if parent.sprite.frame == 11 and !parent.sound.playing:
		parent.sound.play("FootStep")
	
	return null
