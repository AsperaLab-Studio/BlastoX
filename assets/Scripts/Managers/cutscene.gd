extends VideoPlayer

export var next_scene = ""
export var to_mainMenu = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("skip"):
		if to_mainMenu == false:
			get_tree().change_scene("res://scenes/levels/" + Global.dirType + next_scene + ".tscn")
			
		else:
			get_tree().change_scene("res://scenes/misc/MainMenu.tscn")
			
		
	

func _on_VideoPlayer_finished() -> void:
	if to_mainMenu == false:
		get_tree().change_scene("res://scenes/levels/" + Global.dirType + next_scene + ".tscn")
	else:
		get_tree().change_scene("res://scenes/misc/MainMenu.tscn")
