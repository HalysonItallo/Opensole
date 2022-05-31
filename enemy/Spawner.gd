extends Node2D

const MIN_SPAWN_TIME = 1.5


var preloadedEnemies := [
	preload("res://enemy/FastEnemy.tscn"),
	preload("res://enemy/SlowEnemy.tscn"),
	preload("res://enemy/BouncerEnemy.tscn")
]

var preloadedAsteroids := [
	preload("res://asteroid/Asteroid.tscn"),
	preload("res://asteroid/Asteroid2.tscn"),
	preload("res://asteroid/Asteroid3.tscn")
]

onready var spwanTimer = $SpawnTimer

var nextSpawnTime := 5.0

func _ready():
	randomize()
	spwanTimer.start(nextSpawnTime)


func spawnEnemy(xPos: float):
	var preloadEnemy = preloadedEnemies[randi() % preloadedEnemies.size()]
	var enemy: Enemy = preloadEnemy.instance()
	enemy.position = Vector2(xPos, position.y)
	get_tree().current_scene.add_child(enemy)


func spawnAsteroid(xPos: float):
	var preloadAsteroid = preloadedAsteroids[randi() % preloadedAsteroids.size()]
	var asteroid = preloadAsteroid.instance()
	asteroid.position = Vector2(xPos, position.y)
	get_tree().current_scene.add_child(asteroid)


func _on_SpawnTimer_timeout():
	var viewRect = get_viewport_rect()
	var xPos := rand_range(viewRect.position.x, viewRect.end.x)
	
	if randf() < 0.5:
		spawnAsteroid(xPos)
	else:
		spawnEnemy(xPos)
	
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
		
	spwanTimer.start(nextSpawnTime)

