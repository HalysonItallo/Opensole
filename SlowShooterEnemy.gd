extends Enemy
class_name SlowEnemy

onready var fireTimer = $FireTimer

export var fireRate := 1.5

func _process(_delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)
