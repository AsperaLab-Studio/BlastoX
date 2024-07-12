extends Control

onready var sprite: Sprite = get_node("Sprite")
onready var stageManager = get_parent().get_parent().get_parent().get_node("StageManager")

export(Array, StreamTexture) var rate_list
export(bool) var boss = false

var rate_points: Array
var actual_rate

func _ready():
	pass


func _process(_delta):
	calculate_points()
	calculate_rate()

	if stageManager.win.visible == true:
		sprite.visible = true

func calculate_points():
	var maxPoints = stageManager.kill * 100
	var pointsTheshold = maxPoints / 4
	var t1 = pointsTheshold * 1
	var t2 = pointsTheshold * 2
	var t3 = pointsTheshold * 3

	rate_points = [t1, t2, t3]
	

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
	else:
		actual_rate = 3
		
	sprite.texture = rate_list[actual_rate]
