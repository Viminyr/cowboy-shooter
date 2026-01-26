class_name State

extends Node

@export var animation_name : String

var parent : CharacterBody2D
var animation : AnimationPlayer
var states : Dictionary
func enter() -> void:
	animation.play(animation_name)

func exit() -> void:
	pass

func process_physics(_delta: float) -> State:
	return null

func process_input(_input: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null
