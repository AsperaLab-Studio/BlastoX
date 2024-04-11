extends VideoPlayer        

func _ready():          
	set_process(true)

func _process(_delta): 
	if not is_playing():
		play()


func _on_VolumeSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value);


func _on_SFXSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value);
