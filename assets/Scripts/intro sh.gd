extends VideoPlayer

func _ready() -> void:
	pass # Replace with function body.

func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene("res://scenes/cutscenes/advise.tscn")
