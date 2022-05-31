extends Area2D

var preBulletFx := preload("res://bullet/BulletFX.tscn")

export var speed = 1500

func _physics_process(delta):
	position.y -= speed * delta


func showBulletFx():
	var bulletFx := preBulletFx.instance()
	bulletFx.position = position
	get_parent().add_child(bulletFx)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # para a bala deixar de existir ao sair da tela


func _on_Bullet_area_entered(area):
	if area.is_in_group("damageable"):
		showBulletFx()
		area.takeDamage(1)
		queue_free()
