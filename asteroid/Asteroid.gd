extends Area2D

export var minSpeed: float = 32
export var maxSpeed: float = 256
export var minRotationRate = -256
export var maxRotationRate = 256

export var lifePoints: int = 15

var speed: float = 0
var rotationRate: float = 0
var playerInArea: Player = null


func _ready():
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)


func _process(delta):
	if playerInArea != null:
		playerInArea.takeDamage(1)
	

func _physics_process(delta):
	position.y += speed * delta
	rotation_degrees += rotationRate * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Asteroid_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_Asteroid_area_exited(area):
	if area is Player:
		playerInArea = null


func takeDamage(damageAmount: int):
	lifePoints -= damageAmount
	if lifePoints <= 0:
		queue_free()

