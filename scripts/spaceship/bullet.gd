extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var direction = Vector2.UP
var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #para a bala deixar de existir ao sair da tela
