extends Area2D

export var speed = 1500

func _physics_process(delta):
	position.y -= speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # para a bala deixar de existir ao sair da tela
