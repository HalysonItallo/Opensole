extends Area2D
class_name Player

export var speed: float = 1024
export var fireDelay: float = 0.15
export var life: int = 5
export var damageInvincibilityTime: float = 1.25

var velocity := Vector2(0, 0)

onready var bullet_instance = preload("res://bullet/Bullet.tscn") # instancia do projetil

onready var shootPositions := $ShootPositions
onready var fireDelayTimer := $FireDelay
onready var invincibilityTimer := $Invincibility
onready var shieldSprite := $Shield

func _ready():
	var viewportSize := get_viewport_rect().size
	var yOffset = (viewportSize.y * 10) / 100 # 10% acima
	position.x = viewportSize.x / 2.0 # Metade da tela à direita (na verdade centraliza, começando de 0,0)
	position.y = viewportSize.y - yOffset
	
	shieldSprite.visible  = false
	Signals.emit_signal("on_player_life_changed", life)


func _process(delta):
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		#botao shoot definido em configuracoes de entrada
		pressShoot()
		
	resetVelocity()
	var directionVector := Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		directionVector.x = -1
	elif Input.is_action_pressed("ui_right"):
		directionVector.x = 1

	if Input.is_action_pressed("ui_up"):
		directionVector.y = -1
	elif Input.is_action_pressed("ui_down"):
		directionVector.y = 1
		
	velocity = directionVector.normalized() * speed
	position += velocity * delta
	
	adjustPlayerBounds()

	
func resetVelocity():
	velocity.y = 0
	velocity.x = 0


func adjustPlayerBounds():
	# Manter o player na tela
	var viewRect := get_viewport_rect()
	var yOffset = 60
	var xOffset = 46
	position.x = clamp(position.x, xOffset, viewRect.size.x - xOffset)
	position.y = clamp(position.y, yOffset, viewRect.size.y - yOffset)


func pressShoot():
	fireDelayTimer.start(fireDelay)
	for child in shootPositions.get_children():
		var bullet = bullet_instance.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)


func takeDamage(damageAmount: int):
	if !invincibilityTimer.is_stopped():
		return
		
	invincibilityTimer.start(damageInvincibilityTime)
	shieldSprite.visible = true
	
	life -= damageAmount
	Signals.emit_signal("on_player_life_changed", life)
	
	if (life <= 0):
		print("You died")
		queue_free()
	


func _on_Invincibility_timeout():
	shieldSprite.visible = false
