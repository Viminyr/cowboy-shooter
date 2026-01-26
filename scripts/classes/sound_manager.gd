extends Node

class_name Sound_Manager

var playing = false

func play(sound_name : String) -> void:
	playing = true
	var sound = get_node(sound_name)
	if !sound.get_signal_connection_list("finished"):
		sound.connect("finished", sound_finished)
	sound.play()

func sound_finished():
	playing = false
