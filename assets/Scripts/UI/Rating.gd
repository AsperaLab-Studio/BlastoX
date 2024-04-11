extends Control

onready var sprite: Sprite = get_node("Sprite")
onready var stageManager = get_parent().get_parent().get_parent().get_node("StageManager")

export(Array, StreamTexture) var rate_list
export(bool) var boss = false

export(Array, int) var rate_points

var actual_rate

func _ready():
	pass


func _process(_delta):
	calculate_rate()

	if stageManager.win.visible == true:
		sprite.visible = true

func calculate_rate():
	var score
	if !boss:
		score = stageManager.points
	else:
		score = Global.scoreZone

	if score <= rate_points[0]:
		actual_rate = 0
	elif score <= rate_points[1]:
		actual_rate = 1
	elif score <= rate_points[2]:
		actual_rate = 2
	elif score <= rate_points[3]:
		actual_rate = 3
		
	sprite.texture = rate_list[actual_rate]
