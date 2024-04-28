extends Node2D

func _on_StaticBody2D_area_entered(_area):
	if _area.name != "BulletArea":
		visible = false
		Wwise.set_state_id(AK.STATES.MUSICTRIGGER.GROUP, AK.STATES.MUSICTRIGGER.STATE.COMBAT)

func _on_Go_visibility_changed():
	if visible == true:
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.NEXT_AREA, self.get_parent())

func _on_GAME_OVER_visibility_changed():
	if visible == true:
		Wwise.set_state_id(AK.STATES.MUSICTRIGGER.GROUP, AK.STATES.MUSICTRIGGER.STATE.DEFEAT)
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.GAMEOVER_PLAY_MUSIC, self.get_parent())	

func _on_WIN_visibility_changed():
	if visible == true:
		Wwise.set_state_id(AK.STATES.MUSICTRIGGER.GROUP, AK.STATES.MUSICTRIGGER.STATE.VICTORY)
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.GAMEOVER_PLAY_MUSIC, self.get_parent())	
