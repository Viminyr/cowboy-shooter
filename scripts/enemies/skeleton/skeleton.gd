extends CharacterBody2D

class_name Skeleton

@export var move_speed : int
@export var terminal_velocity : int

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $StateMachine
@onready var cast_left: RayCast2D = $CastLeft
@onready var cast_right: RayCast2D = $CastRight

var gravity = GlobalData.gravity
var last_state: State
var health = 2
var direction: int = 0
var wants_attack: bool = false
var deadzone: int = 10

func _ready() -> void:
	state_machine.init(self, animation)
	collision_layer = 4

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	if cast_left.is_colliding():
		if position.x - cast_left.get_collision_point().x > 10:
			switch_direction(-1) #Left
			wants_attack = false
		else:
			wants_attack = true
			direction = 0
	elif cast_right.is_colliding():
		if cast_right.get_collision_point().x - position.x > 10:
			switch_direction(1) #Right
			wants_attack = false
		else:
			wants_attack = true
			direction = 0
	else:
		direction = 0

func update_health(new_health : int, override : bool = false) -> void:
	if health <= 0 :
		return
	if override:
		health = new_health
	else:
		health += new_health
	
	if health <= 0:
		death()

func death() -> void:
	state_machine.change_state(state_machine.states.death)
	collision_layer = 0

func switch_direction(dir: int) -> void:
	direction = dir
	if dir == 1:
		sprite.flip_h = false
	elif dir == -1:
		sprite.flip_h = true
	for box in get_tree().get_nodes_in_group("Hitboxes"):
		box.direction = dir
