extends Area2D
class_name Enemy

var preBullet := preload("res://bullet/EnemyBullet.tscn")
var preEnemyExplosion := preload("res://enemy/EnemyExplosion.tscn")

onready var firingPositions := $FiringPositions

export var verticalSpeed: float = 10.0
export var health: int = 5

var playerInArea: Player = null


func _process(_delta):
	if playerInArea != null:
		playerInArea.takeDamage(1)


func _physics_process(delta):
	position.y += verticalSpeed * delta
	

func fire():
	for child in firingPositions.get_children():
		var bullet = preBullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)


func takeDamage(amount: int):
	if health == 0:
		return
	
	health -= amount
	Signals.emit_signal("on_score_increment", 30)
	
	if health <= 0:
		Signals.emit_signal("on_score_increment", 300)
		showEffect()
		queue_free()


func showEffect():
	var effect := preEnemyExplosion.instance()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null
