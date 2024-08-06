extends AudioStreamPlayer

export(bool)var actualPlaying := false

func _ready(): 
	set_process(true)

func _process(_delta):
	if actualPlaying:
		if not is_playing():
			play()
	else:
		stop()
		
