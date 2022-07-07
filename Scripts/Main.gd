extends Node

func _init():
	randomize()
	
func _ready():
	VisualServer.set_shader_time_scale(300.0) # shader stuff.. can be removed later
	OS.set_window_size(get_viewport().size * 4)
	OS.center_window()

func new_game():
	$CanvasLayer/Player.start($PlayerPosition.position)
	$CanvasLayer/Player.show()
	$Mob.show()
	$MainTheme.play()

func _process(delta):
	# debug mob behaviour
	if Input.is_action_just_pressed("test_key"):
		get_tree().call_group("mobs", "stimulate");

func _on_MainTheme_finished(): #Loop
	$MainTheme.play() 
