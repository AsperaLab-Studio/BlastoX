extends Control

onready var sprite: Sprite = get_node("Sprite")
onready var stageManager = get_parent().get_parent().get_parent().get_node("StageManager")

export(Array, StreamTexture) var rate_list
export(bool) var boss = false

var actual_rate

func _ready():
	pass


func _process(_delta):
	calculate_rate()

	if stageManager.win.visible == true:
		sprite.visible = true
		

func calculate_rate():
	var score
	var maxPoints = stageManager.kill * 100
	if !boss:
		score = stageManager.points
	else:
		score = Global.scoreZone

	if score == maxPoints:
		actual_rate = 3
	elif score >= 0.8 * maxPoints:
		actual_rate = 2
	elif score >= 0.5 * maxPoints:
		actual_rate = 1
	else:
		actual_rate = 0
		
	sprite.texture = rate_list[actual_rate]
