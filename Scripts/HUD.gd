extends CanvasLayer

signal start_game
signal mute(is_muted)

var texture_toggle: int = 1

func _ready():
	pass 

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_AudioButton_toggled(button_pressed):
	emit_signal("mute", button_pressed)
	
