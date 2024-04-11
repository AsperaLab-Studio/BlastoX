extends Camera2D

onready var playerParent = get_parent().get_node("PlayersList")

export(float) var draggingAmount := 5.0
export(float) var borderOffset := 700.0

var playerList
var actual_target

func _ready():
	playerList = playerParent.get_children()

func _process(delta):
	if playerParent.get_child_count() > 0:
		playerList = playerParent.get_children()
		
		actual_target = playerList[0]

		global_position.x = actual_target.global_position.x
		
		if playerParent.get_child_count() > 1:
			checkDragPlayer2(delta)


func checkDragPlayer2(delta):
	var camera_position = get_camera_screen_center()
	var viewport = get_viewport()

	var aspect_ratio = viewport.size.x / viewport.size.y
	var camera_height = 2 * zoom.y
	var camera_width = camera_height * aspect_ratio

	var camera_left_x = camera_position.x - (camera_width + borderOffset / 2)
	var camera_right_x = camera_position.x + (camera_width + borderOffset / 2)

	if playerList[1].global_position.x < camera_left_x:
		var tmp = lerp(playerList[1].global_position.x, camera_left_x + draggingAmount, delta)
		playerList[1].global_position.x = tmp
	if playerList[1].global_position.x > camera_right_x:
		var tmp = lerp(playerList[1].global_position.x, camera_right_x + draggingAmount, delta)
		playerList[1].global_position.x = tmp
