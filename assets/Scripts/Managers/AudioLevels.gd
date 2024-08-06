extends Node2D

onready var Go: AnimatedSprite = get_parent().get_node("GUI/UI/Go")
onready var GAME_OVER: Sprite = get_parent().get_node("GUI/UI/GAME OVER")
onready var WIN: Sprite = get_parent().get_node("GUI/UI/WIN")
onready var Wall: Area2D = get_parent().get_node("Commands/StaticBody2D")
onready var pauseMenu: Control = get_parent().get_node("GUI/pauseMenu")


func _on_Go_visibility_changed():
	if Go.visible == true:
		Go.play()


func _on_GAME_OVER_visibility_changed():
	if GAME_OVER.visible == true:
		GAME_OVER.play()


func _on_WIN_visibility_changed():
	if WIN.visible == true:
		WIN.play()


func _on_StaticBody2D_area_entered(area):
	if area.name != "BulletArea":
		Wall.visible = false
		
