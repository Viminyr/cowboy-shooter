extends Node

class_name enemy_state_machine

@export var states_list: PackedStringArray

@onready var states = {}

@export var starting_state : State
var enemy = CharacterBody2D
var current_state : State

func init(parent: CharacterBody2D, animation: AnimationPlayer) -> void:
	for state in states_list:
		states[str(state)] = get_node(str(state))
	for child in get_children():
		enemy = parent
		child.parent = parent
		child.animation = animation
		child.states = states
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		enemy.last_state = current_state
	
	current_state = new_state
	current_state.enter()
	# print(current_state)

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
