extends Node2D

@onready var gui: CanvasLayer = $GUI

func update_ammo_gauge(ammo : int):
	gui.update_ammo_gauge(ammo)
