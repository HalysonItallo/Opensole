extends Control

var preloadedIcon := preload("res://hud/LifeIcon.tscn")
const STARTING_LIVES = 5
onready var lifeContainer := $LifeContainer
var score: int = 0

onready var scoreLabel := $Score


# Called when the node enters the scene tree for the first time.
func _ready():
	clearLives()
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	Signals.connect("on_score_increment", self, "_on_score_increment")
	

func _on_player_life_changed(life: int):
	setLives(life)


func clearLives():
	for child in lifeContainer.get_children():
		child.queue_free()

func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score)
	pass

func setLives(lives: int):
	clearLives()
	for _i in range(lives):
		lifeContainer.add_child(preloadedIcon.instance())

