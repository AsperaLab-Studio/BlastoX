extends Node2D


func _on_Go_visibility_changed():
	if visible == true:
		$NextArea
