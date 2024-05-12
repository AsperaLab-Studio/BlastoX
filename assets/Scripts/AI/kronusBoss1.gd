class_name KronusBoss1
extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var pivot: Node2D = $Pivot
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $HitBox/CollisionShape2D
onready var collision_shape_body : CollisionShape2D = $CollisionShape2D
onready var StompCooldown_timer : Timer = $StompCooldownTimer
onready var Stomp_timer : Timer = $StompTimer
onready var UIHealthBar: Node2D = get_parent().get_parent().get_parent().get_node("GUI/UI/HealthBossContainer")
onready var camera: Camera2D = get_parent().get_parent().get_parent().get_node("Camera2D")
enum STATE {IDLE, HIT, DIED, STOMP, SHOTGUN, MISSILES}

export var GENERAL_VARS := "____________________"

export(int) var dps := 10
export(int) var HP := 5
export(int) var stompDuration := 2
export(int) var stompDelay := 5

var current_state = STATE.STOMP
var actual_target: Player = null
var directionPlayer = Vector2()
var near_player: bool = false
var healthBar = null
var amount = 0
var paused = false
var areaCollided = null
var targetList = null

var sceneManager = null

var stompFree: bool = true

func _ready():
	anim_player.play("idle")
	healthBar = UIHealthBar
	
	sceneManager = get_parent().get_parent()
	

func _process(_delta: float) -> void:
	actual_target = select_target()
	
	if(!paused):
		match current_state:
			
			STATE.IDLE:
				if stompFree:
					current_state = STATE.STOMP
			
			
			STATE.HIT:
				anim_player.play("hit")
			
			
			STATE.STOMP:
				if stompFree:
					stomp()
			
			
			STATE.DIED:
				collision_shape_body.disabled = true
				collision_shape.disabled = true
				
				anim_player.play("died")
				
		$HealthDisplay/Label.text = STATE.keys()[current_state]
		
	else:
		anim_player.stop()

func select_target() -> Player:
	var distance: float = 100000
	var choosedTarget: Player = null
	for target in targetList:
		var tmpDistance: float = global_position.distance_to(target.global_position)
		if(tmpDistance < distance):
			choosedTarget = target 
			distance = tmpDistance
	
	return choosedTarget


func hit(dpsTaken, attackType, source) -> void:
	if (current_state != STATE.CHARGE_START && current_state != STATE.CHARGE_MID && current_state != STATE.CHARGE_END):
		healthBar.update_healthbar(dpsTaken)
		amount = amount + dpsTaken
		if amount >= HP:
			current_state = STATE.DIED
		else:
			current_state = STATE.HIT


func stomp(): 
	stompFree = false
	Stomp_timer.wait_time = stompDuration
	Stomp_timer.one_shot = true
	camera.smoothing_speed = 5
	camera.get_child(0).shaked = true
	for target in targetList:
		target.paused = true
	Stomp_timer.start()
	StompCooldown_timer.wait_time = stompDelay
	StompCooldown_timer.one_shot = true
	StompCooldown_timer.start()


func set_state_idle():
	camera.smoothing_speed = 0
	camera.get_child(0).shaked = false
	for target in targetList:
		target.paused = false


func _on_StompTimer_timeout():
	set_state_idle()


func _on_StompCooldownTimer_timeout():
	stompFree = true
