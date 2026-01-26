@tool
extends Sprite2D

@export_tool_button("Debug", "Window") var debug_action = debug

func debug():
	print("Hello world!")
