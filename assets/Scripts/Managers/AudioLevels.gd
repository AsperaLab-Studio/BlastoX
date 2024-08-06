extends Node2D

onready var go: AnimatedSprite = get_parent().get_node("GUI/UI/Go")
onready var gameOver: Sprite = get_parent().get_node("GUI/UI/GAME OVER")
onready var win: Sprite = get_parent().get_node("GUI/UI/WIN")
onready var wall: Area2D = get_parent().get_node("Commands/StaticBody2D")
onready var pauseMenu: Control = get_parent().get_node("GUI/pauseMenu")

func _on_Go_visibility_changed():
	if go.visible == true:
		$NextArea.play()


func _on_GAME_OVER_visibility_changed():
	if gameOver.visible == true:
		$Lose.play()
		EnableSection(false, false)


func _on_WIN_visibility_changed():
	if win.visible == true:
		$Win.play()
		EnableSection(false, false)


func _on_StaticBody2D_area_entered(area):
	if area.name != "BulletArea":
		wall.visible = false
		EnableSection(true, false)

func EnableSection(main: bool, intro: bool):
	$Main_Section.actualPlaying = main	
	$Intro_Section.actualPlaying = intro
		
