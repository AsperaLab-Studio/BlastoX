extends Node2D

onready var rnd = RandomNumberGenerator.new()
onready var camera = get_parent()

enum STATE {IDLE, MOVE, ATTACK, HIT, SHOOT, SHAKE, WIN, DIED}

export(bool) var boss = false
export var shakeDecayRate: float = 5.0
export var randomShackeStrenght: float = 30.0

var shaked: bool = false
var defaultOffset
var shakeStrenght: float = 0.0
var timer = Timer.new()


func _ready():
	rnd.randomize()
	defaultOffset = camera.offset
	timer.connect("timeout",self,"do_this")
	timer.wait_time = 1
	timer.one_shot = true
	camera.add_child(timer)
	timer.start()

func _process(delta):
	if boss:
		camera.limit_right = 950
		if shaked == true:
			apply_shake()
			shakeStrenght = lerp(shakeStrenght, 0, shakeDecayRate + delta)
			camera.offset = get_random_offset()
		else:
			camera.offset = defaultOffset
	else:
		pass
		
	

func do_this():
	if boss == false:
		camera.smoothing_speed = 5
		timer.disconnect("timeout", self, "do_this")
	else:
		camera.smoothing_speed = 0
		timer.disconnect("timeout", self, "do_this")

func apply_shake():
	shakeStrenght = randomShackeStrenght
	

func get_random_offset() -> Vector2:
	return Vector2(
		rnd.randf_range(-shakeStrenght, shakeStrenght),
		rnd.randf_range(-shakeStrenght, shakeStrenght)
	)
