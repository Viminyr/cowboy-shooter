extends CharacterBody2D

class_name Player

@export var move_speed : int
@export var terminal_velocity = 500
@export var jump_velocity = -400
@export var acceleration = 500
@export var air_accel = 1.2
@onready var state_machine: Node = $StateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var muzzle_flash: PointLight2D = $MuzzleFlash
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var bullet_scene = preload("res://scenes/bullet.tscn")


var last_state : State
var gravity = GlobalData.gravity
var direction : int = 0
var facing_direction : int = 1

func _ready() -> void:
	state_machine.init(self)

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	
	direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		if direction == 1:
			sprite.flip_h = false
			muzzle_flash.position = Vector2(7,-9)
		else:
			sprite.flip_h = true
			muzzle_flash.position = Vector2(-7,-9)
		facing_direction = direction
	
	state_machine.process_physics(delta)

func shoot() -> void:
	var gun_smoke = $GunParticles.duplicate()
	add_child(gun_smoke)
	gun_smoke.emit(facing_direction)
	
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.direction = facing_direction
	bullet_instance.position = position + Vector2(7 * facing_direction, -9)
	GlobalData.game.add_child(bullet_instance)
