class_name State

extends Node

@export var animation_name : String

var parent : CharacterBody2D

func enter() -> void:
	parent.animation.play(animation_name)

func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	return null

func process_input(input: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null
