extends Node

var isMultiplayer: bool = false
var multiplayerReady: bool = false
var dirType = null
var scoreZone = 0
var totalScore = 0

var playerKeyboard_input = [
	"move_up_keyboard",
	"move_down_keyboard",
	"move_left_keyboard",
	"move_right_keyboard",
	"attack1_keyboard",
	"attack2_keyboard",
	"shoot_keyboard",
	"menu_keyboard",
	"jump_keyboard",
]

var playerPad1_input = [
	"move_up_pad1",
	"move_down_pad1",
	"move_left_pad1",
	"move_right_pad1",
	"attack1_pad1",
	"attack2_pad1",
	"shoot_pad1",
	"menu_pad1",
	"jump_pad1",
]

var playerPad2_input = [
	"move_up_pad2",
	"move_down_pad2",
	"move_left_pad2",
	"move_right_pad2",
	"attack1_pad2",
	"attack2_pad2",
	"shoot_pad2",
	"menu_pad2",
	"jump_pad2",
]

var player1_input
var player2_input

func _process(_delta):
	if Input.get_connected_joypads().size() > 0:
		multiplayerReady = true
	
	if Global.isMultiplayer:
		dirType = "multiplayer/"
	else:
		dirType = "singleplayer/"
	
	if isMultiplayer:
		if Input.get_connected_joypads().size() == 1:
			player1_input = playerKeyboard_input
			player2_input = playerPad1_input
		if Input.get_connected_joypads().size() == 2:
			player1_input = playerPad1_input
			player2_input = playerPad2_input
	else:
		if Input.get_connected_joypads().size() == 0:
			player1_input = playerKeyboard_input
			player2_input = playerPad1_input
		if Input.get_connected_joypads().size() == 1:
			player1_input = playerPad1_input
			player2_input = playerKeyboard_input
