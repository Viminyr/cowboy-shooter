extends CharacterBody2D

class_name Skeleton

@export var move_speed : int
@export var terminal_velocity : int

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $StateMachine
@onready var cast_left: RayCast2D = $CastLeft
@onready var cast_right: RayCast2D = $CastRight
var gravity = GlobalData.gravity
