extends Node

class_name state_machine

@export var starting_state : State
var player = Player
var current_state : State

func init(parent: Player) -> void:
	for child in get_children():
		player = parent
		child.parent = parent
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		player.last_state = current_state
	
	current_state = new_state
	current_state.enter()
	#print(current_state)

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(input: InputEvent) -> void:
	var new_state = current_state.process_input(input)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
