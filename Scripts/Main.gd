extends Node

# allows us to duplicate mobs
export(PackedScene) var mob_scene

func _init():
	randomize()

func _ready():
	VisualServer.set_shader_time_scale(300.0) # shader stuff.. can be removed later
	OS.set_window_size(get_viewport().size * 4)
	OS.center_window()

func _process(delta):
	# debug mob behaviour
	if Input.is_action_just_pressed("test_key"):
		get_tree().call_group("mobs", "stimulate");
