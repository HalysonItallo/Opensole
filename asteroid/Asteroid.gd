extends Area2D
class_name Asteroid

var preAsteroidFx := preload("res://asteroid/AsteroidFx.tscn")

export var minSpeed: float = 32
export var maxSpeed: float = 160
export var minRotationRate = -64
export var maxRotationRate = 64

export var lifePoints: int = 15

var speed: float = 0
var rotationRate: float = 0
var playerInArea: Player = null

var score_value = 0
signal score_changed

func _ready():
	var label = get_tree().get_root().get_node("GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label,"update_score")
	
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)


func _process(_delta):
	if playerInArea != null:
		playerInArea.takeDamage(1)
	

func _physics_process(delta):
	position.y += speed * delta
	rotation_degrees += rotationRate * delta


func takeDamage(damageAmount: int):
	lifePoints -= damageAmount
	if lifePoints <= 0:
		Signals.emit_signal("on_score_increment",50)
		
		showDestroyEffect()
		queue_free()


func showDestroyEffect():
	Signals.emit_signal("score_changed",score_value)
	
	var asteroidFx := preAsteroidFx.instance()
	asteroidFx.position = position
	get_parent().add_child(asteroidFx)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Asteroid_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_Asteroid_area_exited(area):
	if area is Player:
		playerInArea = null
