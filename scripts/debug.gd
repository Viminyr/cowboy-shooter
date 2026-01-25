@tool

extends TextureRect

const AMMO_GAUGE_0 = preload("res://assets/sprites/Ammo Gauge0.png")
const AMMO_GAUGE_1 = preload("res://assets/sprites/Ammo Gauge1.png")
const AMMO_GAUGE_2 = preload("res://assets/sprites/Ammo Gauge2.png")
const AMMO_GAUGE_3 = preload("res://assets/sprites/Ammo Gauge3.png")
const AMMO_GAUGE_4 = preload("res://assets/sprites/Ammo Gauge4.png")
const AMMO_GAUGE_5 = preload("res://assets/sprites/Ammo Gauge5.png")
const AMMO_GAUGE_6 = preload("res://assets/sprites/Ammo Gauge6.png")

func _process(delta: float) -> void:
	var AMMO_GAUGE_number = "AMMO_GAUGE_" + "0"
	texture = str_to_var(AMMO_GAUGE_number)
