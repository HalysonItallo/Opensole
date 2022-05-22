extends Area2D

export var speed: float = 1024
var velocity := Vector2(0, 0)

func _ready():
	var viewportSize := get_viewport_rect().size
	var yOffset = (viewportSize.y * 10) / 100 # 10% acima
	position.x = viewportSize.x / 2.0 # Metade da tela à direita (na verdade centraliza, começando de 0,0)
	position.y = viewportSize.y - yOffset

func _process(delta):
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
	var yOffset = 90
	var xOffset = 54
	position.x = clamp(position.x, xOffset, viewRect.size.x - xOffset)
	position.y = clamp(position.y, yOffset, viewRect.size.y - yOffset)
