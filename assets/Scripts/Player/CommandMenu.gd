extends Control

onready var option: Control = get_parent().get_node("OptionMenu")

func _on_BackBtn_pressed():
	option.visible = true
	visible = false
