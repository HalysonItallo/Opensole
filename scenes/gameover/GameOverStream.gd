extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var audioStream: AudioStream = preload("res://audio/game_over.ogg")
	self.set_stream(audioStream)
	play()
