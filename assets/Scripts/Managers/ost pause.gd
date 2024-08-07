extends AudioStreamPlayer

func _ready(): 
	set_process(true)

func _process(_delta):
	if get_tree().paused:
		if not is_playing():
			play()
	else:
		stop()
		
func pause():
	pass