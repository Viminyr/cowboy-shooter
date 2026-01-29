extends State

var animation_finished: bool = false

func enter() -> void:
	animation_finished = false

	super()
	if !animation.get_signal_connection_list("animation_finished"):
		animation.connect("animation_finished", _on_animation_finished)

func process_physics(delta: float) -> State:
	parent.velocity.x = 0
	parent.velocity.y = move_toward(parent.velocity.y, parent.terminal_velocity, parent.gravity * delta)
	parent.move_and_slide()
	
	return null

func process_frame(_delta: float) -> State:
	if animation_finished:
		return states.Idle
	
	if parent.sprite.frame == 26:
		parent.hit_box.collision_shape.disabled = false
	else:
		parent.hit_box.collision_shape.disabled = true
		
	if parent.sprite.frame == 25 and !parent.sound.playing:
		parent.sound.play("Punch")
	
	return null


func _on_animation_finished(anim_name: StringName) -> void:
	animation_finished = true
