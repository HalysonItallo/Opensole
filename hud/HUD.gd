extends Control

var preloadedIcon := preload("res://HUD/LifeIcon.tscn")
const STARTING_LIVES = 5
onready var lifeContainer := $LifeContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	clearLives()
	setLives(STARTING_LIVES)


func clearLives():
	for child in lifeContainer.get_children():
		child.queue_free()


func setLives(lives: int):
	clearLives()
	for i in range(lives):
		lifeContainer.add_child(preloadedIcon.instance())

