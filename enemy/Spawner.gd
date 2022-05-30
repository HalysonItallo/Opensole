extends Node2D

const MIN_SPAWN_TIME = 1.5


var preloadAsteroid = preload("res://asteroid/Asteroid.tscn")
var preloadedEnemies := [
	preload("res://enemy/FastEnemy.tscn"),
	preload("res://enemy/SlowEnemy.tscn"),
	preload("res://enemy/BouncerEnemy.tscn")
]

onready var spwanTimer = $SpawnTimer

var nextSpawnTime := 5.0

func _ready():
	randomize()
	spwanTimer.start(nextSpawnTime)


func spawnEnemy(xPos: int):
	var preloadEnemy = preloadedEnemies[randi() % preloadedEnemies.size()]
	var enemy: Enemy = preloadEnemy.instance()
	enemy.position = Vector2(xPos, position.y)
	get_tree().current_scene.add_child(enemy)


func spawnAsteroid(xPos: int):
	var asteroid: Asteroid = preloadAsteroid.instance()
	asteroid.position = Vector2(xPos, position.y)
	get_tree().current_scene.add_child(asteroid)


func _on_SpawnTimer_timeout():
	var viewRect = get_viewport_rect()
	var xPos := rand_range(viewRect.position.x, viewRect.end.x)
	
	if randf() < 0.3:
		spawnAsteroid(xPos)
	else:
		spawnEnemy(xPos)
	
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
		
	spwanTimer.start(nextSpawnTime)

