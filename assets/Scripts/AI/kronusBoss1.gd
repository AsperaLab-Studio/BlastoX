class_name KronusBoss1
extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var pivot: Node2D = $Pivot
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $Pivot/HitBox/CollisionShape2D
onready var collision_shape_body : CollisionShape2D = $CollisionShape2D
onready var UIHealthBar: Node2D = $UI/HealthContainer
onready var camera: Camera2D = get_parent().get_parent().get_parent().get_node("Camera2D")
onready var AttackCooldown_timer : Timer = $AttackCooldownTimer

signal hasDied

enum STATE {IDLE, HIT, DIED, STOMP, SHOTGUN, MISSILES}

export var GENERAL_VARS := "____________________"
export(int) var dps := 10
export(int) var HP := 5
export(float) var wait_attack := 2.0

export var SHOTGUN_VARS := "____________________"
export(int) var dps_shotgun := 2
export(int) var numberOfBullets  := 5
export(float) var shootingAmplitude  := 30.0
onready var spawnRifle : Position2D = $Pivot/MissilePos
export(PackedScene) var bullet
export(float) var shotgunCooldown := 3

export var MISSILES_VARS := "____________________"
onready var missile : KronusMissile = $Missile
onready var spawnMissile : Position2D = $Pivot/MissilePos
export(float) var missilesCooldown := 3

export var STOMP_VARS := "____________________"
onready var Stomp_timer : Timer = $StompTimer
onready var StompCooldown_timer : Timer = $StompCooldownTimer
export(int) var stompDuration := 2
export(int) var stompDelay := 5
export(int) var stompCooldown := 5


var current_state = STATE.IDLE
var actual_target: Player = null
var directionPlayer = Vector2()
var near_player: bool = false
var healthBar = null
var amount = 0
var paused = false
var areaCollided = null
var targetList = null
var stompFree: bool = true

var sceneManager = null

var attackCounter = 0
var canShootShotgun = true

func _ready():
	healthBar = UIHealthBar
	
	sceneManager = get_parent().get_parent()

func _process(_delta: float) -> void:
	actual_target = select_target()
	flip_sprite(actual_target.global_position)
	
	if(!paused):
		match current_state:
			
			STATE.IDLE:
				anim_player.play("idle")
			
			STATE.HIT:
				anim_player.play("hit")
			
			STATE.STOMP:
				if Stomp_timer.is_stopped() && stompFree:
					anim_player.play("stomp")
				if anim_player.current_animation != "stomp":
					current_state = STATE.IDLE
			
			STATE.MISSILES:
				anim_player.play("missiles")
			
			STATE.SHOTGUN:
				anim_player.play("shotgun")
			
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

func flip_sprite(target: Vector2):
	if target:
		if global_position.y > target.y:
			z_index = 0
		else:
			z_index = -1
		
		var velocity = global_position.direction_to(target)
		
		if velocity.x < 0:
			sprite.flip_h = true
			if pivot.scale.x > 0:
				pivot.scale.x = - pivot.scale.x
		elif velocity.x > 0:
			sprite.flip_h = false
			if pivot.scale.x < 0:
				pivot.scale.x = - pivot.scale.x


func hit(dpsTaken, attackType, source) -> void:
	healthBar.update_healthbar(dpsTaken)
	amount = amount + dpsTaken
	if amount >= HP:
		current_state = STATE.DIED
	else:
		current_state = STATE.HIT

func death():
	emit_signal("hasDied")
	queue_free()
	
func stomp(): 
	stompFree = false
	Stomp_timer.wait_time = stompDuration
	Stomp_timer.one_shot = true
	camera.smoothing_speed = 5
	camera.get_child(0).shaked = true
	for target in targetList:
		target.paused = true
	Stomp_timer.start()
	StompCooldown_timer.wait_time = stompCooldown
	StompCooldown_timer.one_shot = true
	StompCooldown_timer.start()

func set_state_idle():
	camera.smoothing_speed = 0
	camera.get_child(0).shaked = false
	for target in targetList:
		target.paused = false

func stop_hit():
	current_state = STATE.IDLE

func shotgun_shoot():
	if canShootShotgun:
		canShootShotgun = false
		var deltaAngle = shootingAmplitude/(numberOfBullets -1)
		var directionRifle = spawnRifle.get_global_position().direction_to(actual_target.global_position)
		var angle = -sign(directionRifle.y) * acos(abs(directionRifle.x))

		var i = 0
		for n in numberOfBullets:
			var bullet_instance = bullet.instance()
			var angleOffset = shootingAmplitude/2 - deltaAngle * i
			bullet_instance.rotate(angle + deg2rad(angleOffset))
			bullet_instance.direction = Vector2(cos(bullet_instance.rotation), sin(bullet_instance.rotation))
			get_parent().get_parent().get_parent().get_parent().add_child(bullet_instance)
			bullet_instance.set_global_position(spawnRifle.get_global_position())
			i+=1
		start_attack_cooldown(shotgunCooldown)

func missile_shoot():
	missile.position2d = spawnMissile
	missile.shoot(actual_target)

func _on_StompTimer_timeout():
	set_state_idle()

func _on_Missile_HasShootMissile():
	start_attack_cooldown(missilesCooldown)

func start_attack_cooldown(value):
	AttackCooldown_timer.wait_time = value
	AttackCooldown_timer.one_shot = true
	AttackCooldown_timer.start()
	updateCounter()

func _on_AttackCooldownTimer_timeout():
	current_state = STATE.IDLE

func updateCounter():
	attackCounter += 1
	

func choose_state():
	if stompFree:
		current_state = STATE.STOMP
	elif (!attackCounter % 2 == 0):
		canShootShotgun = true
		current_state = STATE.SHOTGUN
	else:
		current_state = STATE.MISSILES


func _on_StompCooldownTimer_timeout():
	stompFree == true


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "hit"):
		current_state == STATE.IDLE
