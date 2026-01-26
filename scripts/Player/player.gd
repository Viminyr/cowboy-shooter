extends CharacterBody2D

class_name Player

@export var move_speed : int = 100
@export var terminal_velocity = 500
@export var jump_velocity = -300
@export var acceleration = 1500
@export var air_accel : float = 1.2
@export var max_ammo : int = 6
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var state_machine: Node = $StateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var muzzle_flash: PointLight2D = $MuzzleFlash
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var reload_timer: Timer = $ReloadTimer
@onready var sound: Node = $SoundManager

var ammo = max_ammo
var last_state : State
var gravity = GlobalData.gravity
var direction : int = 0
var facing_direction : int = 1

func _ready() -> void:
	state_machine.init(self, animation)
	reload_timer.connect("timeout", _on_reload_timer_timout)

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)
	if Input.is_action_just_pressed("reload"):
		reload()

func _physics_process(delta: float) -> void:
	@warning_ignore("narrowing_conversion")
	direction = Input.get_axis("move_left", "move_right")
	
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if direction:
		if direction == 1:
			sprite.flip_h = false
			muzzle_flash.position = Vector2(7,-9)
		else:
			sprite.flip_h = true
			muzzle_flash.position = Vector2(-7,-9)
		facing_direction = direction
	
	state_machine.process_frame(delta)

func shoot() -> void:
	ammo -= 1
	GlobalData.game.update_ammo_gauge(ammo)
	sound.play("GunShot")
	var gun_smoke = $GunParticles.duplicate()
	add_child(gun_smoke)
	gun_smoke.emit(facing_direction)
	
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.direction = facing_direction
	bullet_instance.position = position + Vector2(7 * facing_direction, -9)
	GlobalData.game.add_child(bullet_instance)
	if ammo < 1:
		reload()
	else:
		reload_timer.stop()

func reload() -> void:
	#print("reloading...")
	reload_timer.start()

func _on_reload_timer_timout():
	if ammo < max_ammo:
		ammo += 1
		reload_timer.start()
	GlobalData.game.update_ammo_gauge(ammo)
