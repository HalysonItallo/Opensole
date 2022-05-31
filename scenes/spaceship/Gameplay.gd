extends Node

export var speed: int = 386

var direction := Vector2(0, 1)

onready var parallax = $ParallaxBackground


func _process(delta):
	parallax.scroll_offset += direction * speed * delta
