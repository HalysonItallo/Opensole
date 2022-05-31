extends Control

var preloadedIcon := preload("res://hud/LifeIcon.tscn")
var preHitAudioStream: AudioStream = preload("res://audio/enemy_hit.ogg")
var preBulletHitAudioStream: AudioStream = preload("res://audio/enemy_bullet_hit.ogg")
var prePlayerDamageAudioStream: AudioStream = preload("res://audio/player_damage.ogg")

onready var lifeContainer := $LifeContainer
onready var hitAudioStream := $EnemyHitStream
onready var enemyHitAudioStream := $EnemyBulletHitStream
onready var playerDamageStream := $PlayerDamageStream
onready var scoreLabel := $Score

const STARTING_LIVES = 7

var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	hitAudioStream.set_stream(preHitAudioStream)
	clearLives()
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	Signals.connect("on_score_increment", self, "_on_score_increment")
	

func _on_player_life_changed(life: int):
	playerDamageStream.play()
	setLives(life)


func clearLives():
	for child in lifeContainer.get_children():
		child.queue_free()

func _on_score_increment(amount: int):
	if amount == 300: # Enemy kill
		hitAudioStream.play()
	else:
		enemyHitAudioStream.play()
	
	score += amount
	scoreLabel.text = str(score)
	pass


func setLives(lives: int):
	clearLives()
	for _i in range(lives):
		lifeContainer.add_child(preloadedIcon.instance())

