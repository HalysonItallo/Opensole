extends Control


var firstFocus = true


func _ready():
	$StartButton.grab_focus()
	firstFocus = false


func _on_StartButton_pressed():
	$MenuConfirm.play()
	get_tree().change_scene("res://scenes/spaceship/Gameplay.tscn")


func _on_StartButton_focus_entered():
	if (firstFocus):
		return
	$MenuSelect.play()


func _on_StartButton_mouse_entered():
	$StartButton.grab_focus()
