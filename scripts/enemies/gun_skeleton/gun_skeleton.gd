extends CharacterBody2D

class_name Gun_Skeleton

@export var move_speed : int
@export var terminal_velocity : int

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $StateMachine
@onready var cast_left: RayCast2D = $CastLeft
@onready var cast_right: RayCast2D = $CastRight
@onready var muzzle_flash: PointLight2D = $MuzzleFlash
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var sound: Sound_Manager = $Sound_Manager

var gravity = GlobalData.gravity
var last_state: State
var health = 2
var direction: int = 0
var facing_direction: int = 1
var wants_attack: bool = false
var deadzone: int = 10

signal add_child_to_game_world(child)

func _ready() -> void:
	state_machine.init(self, animation)
	collision_layer = 4

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	if cast_left.is_colliding():
		if position.x - cast_left.get_collision_point().x > 50: #Target is farther than 50px
			switch_facing_direction(-1) #Left
			wants_attack = true
		else: #Target is closer than 20px
			switch_direction(1) #Right
			wants_attack = false
	elif cast_right.is_colliding():
		if cast_right.get_collision_point().x - position.x > 50: #Target is farther than 50px
			switch_facing_direction(1) #Right
			wants_attack = true
		else: #Target is closer than 20px
			wants_attack = false
			switch_direction(-1) #left
	else:
		wants_attack = false
		direction = 0

func update_health(new_health : int, _dealt_by: Node, override : bool = false) -> void:
	if health <= 0 :
		return
	if override:
		health = new_health
	else:
		health += new_health
	if health <= 0:
		death()
	else:
		sound.play("Hurt")

func death() -> void:
	state_machine.change_state(state_machine.states.Death)
	collision_layer = 0

func switch_direction(dir: int) -> void:
	if health > 0:
		direction = dir
		facing_direction = dir
		muzzle_flash.position = Vector2(6 * dir,-10)
		if dir == 1:
			sprite.flip_h = false
		elif dir == -1:
			sprite.flip_h = true

func switch_facing_direction(dir: int) -> void:
	if dir == 0:
		return
	if health > 0:
		facing_direction = dir
		muzzle_flash.position = Vector2(7 * dir,-9)
		if dir == 1:
			sprite.flip_h = false
		elif dir == -1:
			sprite.flip_h = true

func shoot() -> void:
	sound.play("GunshotSmall")
	var gun_smoke = $GunParticles.duplicate()
	add_child(gun_smoke)
	gun_smoke.emit(facing_direction)
	
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.direction = facing_direction
	bullet_instance.position = position + Vector2(9 * facing_direction, -9)
	bullet_instance.speed = 100
	bullet_instance.lifetime = 1.5
	bullet_instance.collision_mask = 1 | 2
	add_child_to_game_world.emit(bullet_instance)
