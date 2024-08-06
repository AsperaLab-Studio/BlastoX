extends AudioStreamPlayer


func _ready(): 
	set_process(true)

func _process(_delta):
	set_process(true)
	play() 

func pause():
	if not is_playing():
		stop()

