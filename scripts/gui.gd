extends CanvasLayer

@onready var ammo_gauge: TextureRect = $Control/MarginContainer/AmmoGauge
const AMMO_GAUGE_0 = preload("res://assets/sprites/Ammo Gauge0.png")
const AMMO_GAUGE_1 = preload("res://assets/sprites/Ammo Gauge1.png")
const AMMO_GAUGE_2 = preload("res://assets/sprites/Ammo Gauge2.png")
const AMMO_GAUGE_3 = preload("res://assets/sprites/Ammo Gauge3.png")
const AMMO_GAUGE_4 = preload("res://assets/sprites/Ammo Gauge4.png")
const AMMO_GAUGE_5 = preload("res://assets/sprites/Ammo Gauge5.png")
const AMMO_GAUGE_6 = preload("res://assets/sprites/Ammo Gauge6.png")

func update_ammo_gauge(ammo : int):
	ammo_gauge.texture = get_texture(ammo)

func get_texture(ammo : int):
	var texture
	match ammo:
		0:
			texture = AMMO_GAUGE_0
		1:
			texture = AMMO_GAUGE_1
		2:
			texture = AMMO_GAUGE_2
		3:
			texture = AMMO_GAUGE_3
		4:
			texture = AMMO_GAUGE_4
		5:
			texture = AMMO_GAUGE_5
		6:
			texture = AMMO_GAUGE_6
	return texture
