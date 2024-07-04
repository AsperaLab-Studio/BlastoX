extends Node2D

onready var Go: AnimatedSprite = get_parent().get_node("GUI/UI/Go")
onready var GAME_OVER: Sprite = get_parent().get_node("GUI/UI/GAME OVER")
onready var WIN: Sprite = get_parent().get_node("GUI/UI/WIN")
onready var Wall: Area2D = get_parent().get_node("Commands/StaticBody2D")
onready var pauseMenu: Control = get_parent().get_node("GUI/pauseMenu")


func _on_StaticBody2D_area_entered(_area):
	if _area.name != "BulletArea":
		Wall.visible = false
		Wwise.set_state_id(AK.STATES.MUSICTRIGGER.GROUP, AK.STATES.MUSICTRIGGER.STATE.COMBAT)

func _on_Go_visibility_changed():
	if Go.visible == true:
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.NEXT_AREA, self.get_parent())

func _on_GAME_OVER_visibility_changed():
	if GAME_OVER.visible == true:
		Wwise.set_state_id(AK.STATES.MUSICTRIGGER.GROUP, AK.STATES.MUSICTRIGGER.STATE.DEFEAT)
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.GAMEOVER_PLAY_MUSIC, self.get_parent())

func _on_WIN_visibility_changed():
	if WIN.visible == true:
		Wwise.set_state_id(AK.STATES.MUSICTRIGGER.GROUP, AK.STATES.MUSICTRIGGER.STATE.VICTORY)
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.GAMEOVER_PLAY_MUSIC, self.get_parent())

func _on_pauseMenu_visibility_changed():
	if pauseMenu.visible == true:
		Wwise.set_pause_mode(2)
		Wwise.set_state_id(AK.STATES.MUSICPAUSE.GROUP, AK.STATES.MUSICPAUSE.STATE.PAUSE)
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.MENU_BUTTON_PRESSED, self.get_parent())
	else:
		Wwise.set_state_id(AK.STATES.MUSICPAUSE.GROUP, AK.STATES.MUSICPAUSE.STATE.RESUME)
		Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
		Wwise.post_event_id(AK.EVENTS.MENU_MOUSE_OVER, self.get_parent())
