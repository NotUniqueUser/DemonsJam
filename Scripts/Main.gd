extends Node

# allows us to duplicate mobs
export(PackedScene) var mob_scene
var mute:bool = false

func _init():
	randomize()

func _ready():
	#randomize() #if we want the game to run randomly each run
	VisualServer.set_shader_time_scale(300.0) # shader stuff.. can be removed later
	OS.set_window_size(get_viewport().size * 4)
	OS.center_window()

func new_game():
	$CanvasLayer/Player.start($PlayerPosition.position)
	$CanvasLayer/Player.show()
	$Mob.show()
	$HUD/AudioButton.hide()
	if !mute:
		$MainTheme.play()
	
func _process(delta):
	# debug mob behaviour
	if Input.is_action_just_pressed("test_key"):
		get_tree().call_group("mobs", "stimulate");

func _on_MainTheme_finished(): #Loop
	$MainTheme.play() 

func _on_HUD_mute(is_muted):
	mute = is_muted
