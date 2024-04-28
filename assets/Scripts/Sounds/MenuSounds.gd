extends Node2D

func ButtonSound():
	Wwise.register_game_obj(self, self.name)
	Wwise.post_event_id(AK.EVENTS.MENU_BUTTON_PRESSED, self)

func OverSound():
	Wwise.register_game_obj(self, self.name)
	Wwise.post_event_id(AK.EVENTS.MENU_MOUSE_OVER, self)


#MainMenu

func _on_StartBtn_pressed():
	ButtonSound()

func _on_StartBtn_mouse_entered():
	OverSound()

func _on_OptionsBtn_pressed():
	ButtonSound()

func _on_OptionsBtn_mouse_entered():
	OverSound()

func _on_CreditsBtn_pressed():
	ButtonSound()

func _on_CreditsBtn_mouse_entered():
	OverSound()

func _on_ExitBtn_mouse_entered():
	OverSound()


#OptionMenu

func _on_ReturnBtn_pressed():
	ButtonSound()

func _on_ReturnBtn_mouse_entered():
	OverSound()

func _on_checkFullscreen_toggled(button_pressed):
	ButtonSound()

func _on_MusicSlider_value_changed(value: float) -> void:
	Wwise.set_rtpc("Music_Slider", value, null)

func _on_SFXSlider_value_changed(value: float) -> void:
	Wwise.set_rtpc("SFX_Slider", value, null)


#PlayMenu

func _on_SingleBtn_pressed():
	ButtonSound()

func _on_SingleBtn_mouse_entered():
	OverSound()

func _on_MultiBtn_pressed():
	ButtonSound()

func _on_MultiBtn_mouse_entered():
	OverSound()

func _on_LoadBtn_pressed():
	ButtonSound()

func _on_LoadBtn_mouse_entered():
	OverSound()

func _on_BackBtn_pressed():
	ButtonSound()

func _on_BackBtn_mouse_entered():
	OverSound()


# PauseMenu

func _on_RestartLevelBtn_pressed():
	ButtonSound()

func _on_RestartLevelBtn_mouse_entered():
	OverSound()

func _on_OptionBtn_pressed():
	ButtonSound()

func _on_OptionBtn_mouse_entered():
	OverSound()

func _on_MainMenuBtn_pressed():
	ButtonSound()

func _on_MainMenuBtn_mouse_entered():
	OverSound()

func _on_QuitBtn_mouse_entered():
	OverSound()

func _on_backToPauseBtn_pressed():
	ButtonSound()

func _on_backToPauseBtn_mouse_entered():
	OverSound()

func _on_pauseMenu_visibility_changed():
	if visible == true:
		Wwise.set_pause_mode(2)
		Wwise.set_state_id(AK.STATES.MUSICPAUSE.GROUP, AK.STATES.MUSICPAUSE.STATE.PAUSE)
		ButtonSound()
	else:
		Wwise.set_state_id(AK.STATES.MUSICPAUSE.GROUP, AK.STATES.MUSICPAUSE.STATE.RESUME)
		OverSound()
