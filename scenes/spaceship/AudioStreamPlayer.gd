extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var audioStream: AudioStream = preload("res://audio/stage_01.ogg")
	self.set_stream(audioStream)
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
