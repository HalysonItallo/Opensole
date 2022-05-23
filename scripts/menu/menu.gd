extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var firstFocus = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	firstFocus = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	$MenuConfirm.play()
	get_tree().change_scene("res://scenes/spaceship/spacecombat1.tscn")

func _on_StartButton_focus_entered():
	if (firstFocus):
		return
	$MenuSelect.play()

func _on_StartButton_mouse_entered():
	$VBoxContainer/StartButton.grab_focus()
	
func _on_ExitButton_pressed():
	$MenuSelect.play()
	get_tree().quit()

func _on_ExitButton_focus_entered():
	$MenuSelect.play()

func _on_ExitButton_mouse_entered():
	$VBoxContainer/ExitButton.grab_focus()
