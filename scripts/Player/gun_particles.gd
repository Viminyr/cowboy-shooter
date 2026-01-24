extends GPUParticles2D

func emit(facing_direction) -> void:
	restart()
	process_material.direction.x = 90 * facing_direction
	process_material.emission_shape_offset = Vector3(7 * facing_direction, -9, 0)
	emitting = true
	finished.connect(func():
		queue_free())
	
