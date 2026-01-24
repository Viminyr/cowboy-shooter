extends State

@export var idle_state : State
@export var fall_state : State
@export var move_state : State
@export var jump_state : State

var animation_done = false

func enter() -> void:
	super()
	animation_done = false
	parent.animation.animation_finished.connect(_on_animation_finished)
	parent.shoot()

func process_physics(delta : float) -> State:
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	
	if parent.is_on_floor():
		if parent.direction:
			parent.velocity.x = move_toward(
				parent.velocity.x,
				parent.direction * parent.move_speed * 0.25, 
				parent.acceleration * delta
				)
		else:
			parent.velocity.x = move_toward(
				parent.velocity.x,
				0, 
				parent.acceleration * delta
				)
	
	parent.move_and_slide()
	
	if animation_done:
		if parent.is_on_floor():
			if parent.direction:
				return move_state
			else:
				return idle_state
		else:
			return fall_state
	return null

func _on_animation_finished(anim_name: StringName) -> void:
	animation_done = true
