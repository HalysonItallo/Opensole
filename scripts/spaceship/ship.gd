extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func movimentoXY(delta):
	var velocidade = 55
#eixo X
	var eixoX = 0
	if Input.is_action_pressed("ui_left"):
		eixoX += -velocidade
		#translate(Vector2(eixoX,0))
	if Input.is_action_pressed("ui_right"):
		eixoX += velocidade
		#translate(Vector2(eixoX,0))
		
#eixo Y
	var eixoY = 0
	if Input.is_action_pressed("ui_up"):
		eixoY += -velocidade
		#translate(Vector2(eixoY,0))
	if Input.is_action_pressed("ui_down"):
		eixoY += velocidade
		#translate(Vector2(eixoY,0))
	translate(Vector2(eixoX,eixoY))
	
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, -1900, viewRect.size.x)
	position.y = clamp(position.y, -2500, viewRect.size.y)
	

# Called when the node enters the scene tree for the first time.
func _ready(): #equivalente ao init
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movimentoXY(delta)
	pass
