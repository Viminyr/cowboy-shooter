extends CanvasLayer

@onready var health_gauge: TextureRect = $TopLeftMargin/HealthGauge
@onready var ammo_gauge: TextureRect = $TopRightMargin/AmmoGauge

var ammo_textures = [
	preload("res://assets/sprites/Ammo Gauge0.png"),
	preload("res://assets/sprites/Ammo Gauge1.png"),
	preload("res://assets/sprites/Ammo Gauge2.png"),
	preload("res://assets/sprites/Ammo Gauge3.png"),
	preload("res://assets/sprites/Ammo Gauge4.png"),
	preload("res://assets/sprites/Ammo Gauge5.png"),
	preload("res://assets/sprites/Ammo Gauge6.png")
	]
var health_textures = [
	preload("res://assets/sprites/Health-Gauge0.png"),
	preload("res://assets/sprites/Health-Gauge1.png"),
	preload("res://assets/sprites/Health-Gauge2.png"),
	preload("res://assets/sprites/Health-Gauge3.png"),
	preload("res://assets/sprites/Health-Gauge4.png"),
	preload("res://assets/sprites/Health-Gauge5.png"),
	preload("res://assets/sprites/Health-Gauge6.png")
	]

func update_ammo_gauge(ammo : int) -> void:
	ammo_gauge.texture = ammo_textures[ammo]

func update_health_gauge(health: int) -> void:
	health_gauge.texture = health_textures[health]
