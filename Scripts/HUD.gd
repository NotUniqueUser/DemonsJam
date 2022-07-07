extends CanvasLayer

signal start_game
signal mute(is_muted)

<<<<<<< HEAD
=======
var texture_toggle: int = 1

>>>>>>> 1de9735db8146c08af9cf72ba010ab184c26ebdc
func _ready():
	pass 

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_AudioButton_toggled(button_pressed):
	emit_signal("mute", button_pressed)
	
