class_name kronusBoss2
extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var pivot: Node2D = $Pivot
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $Pivot/HitBox/CollisionShape2D
onready var collision_shape_body : CollisionShape2D = $CollisionShape2D
onready var UIHealthBar: Node2D = $UI/HealthContainer
onready var camera: Camera2D = get_parent().get_parent().get_parent().get_node("Camera2D")
onready var AttackCooldown_timer : Timer = $AttackCooldownTimer

enum STATE {IDLE, HIT, DIED, LAVASTOMP, SHOTGUN, MISSILES}

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

export var LAVA_STOMP_VARS := "--------------------"
export(int) var dps_lavastomp := 3
export(PackedScene) var lava_column
onready var lava_column_list_pos: Array = get_parent().get_parent().get_node("spearZones").get_children()
onready var lava_container: Node = get_node("LavaColumnContainer")
var temp_list: Array
var onEnter = true
var rng

export var FLAGS := "____________________"
var hitted: bool = false
var canAttack: bool = true
var lastAttack = STATE.MISSILES

var current_state = STATE.IDLE
var actual_target: Player = null
var directionPlayer = Vector2()
var near_player: bool = false
var healthBar = null
var amount = 0
var paused = false
var areaCollided = null
var targetList = null

var sceneManager = null


func _ready():
	healthBar = UIHealthBar
	
	sceneManager = get_parent().get_parent()

func _process(_delta: float) -> void:
	actual_target = select_target()
	flip_sprite(actual_target.global_position)
	choose_state()
	
	if(!paused):
		match current_state:
			
			STATE.IDLE:
				anim_player.play("idle")
			
			STATE.HIT:
				anim_player.play("hit")
			
			STATE.LAVASTOMP:
				var actual_zone: int

				if onEnter == true:
					canAttack = false
					anim_player.play("lavastomp")
					onEnter = false
					temp_list.clear()
					for lava in lava_column_list_pos:
						temp_list.append(lava)

				elif (anim_player.current_animation != "lavastomp" && 
						temp_list.size() <= lava_column_list_pos.size() && temp_list.size() > 0 &&
						lava_container.get_child_count() == 0):
					randomize()
					actual_zone = int(rand_range(0, temp_list.size()-1))

					var i = 1

					for pos in temp_list[actual_zone].get_children():
						if (global_position.distance_to(pos.global_position) >= 100):
							var actual_lava_column_instance = lava_column.instance()

							if pos.name == "1" || pos.name == "2":
								actual_lava_column_instance.z_index = -1
							else:
								actual_lava_column_instance.z_index = 3
							
							lava_container.add_child(actual_lava_column_instance)
							actual_lava_column_instance.global_transform = pos.global_transform
							i = i + 1

					temp_list.remove(actual_zone)

				elif temp_list.size() == 0 && lava_container.get_child_count() == 0:
					lastAttack = STATE.LAVASTOMP
					AttackCooldown_timer.wait_time = wait_attack
					AttackCooldown_timer.start()
					onEnter = true

			
			STATE.MISSILES:
				anim_player.play("missile")
			
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
	hitted = true
	healthBar.update_healthbar(dpsTaken)
	amount = amount + dpsTaken


func death():
	var phaseChanger : kronusPhaseManager = get_parent()
	phaseChanger.change_to_third_phase()
	queue_free()


func set_state_idle():
	camera.smoothing_speed = 0
	camera.get_child(0).shaked = false
	for target in targetList:
		target.paused = false


func shotgun_shoot():
	canAttack = false
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
	lastAttack = STATE.SHOTGUN
	start_attack_cooldown(shotgunCooldown)

func missile_shoot():
	canAttack = false
	missile.position2d = spawnMissile
	missile.shoot(actual_target)

func _on_StompTimer_timeout():
	set_state_idle()

func _on_Missile_HasShootMissile():
	lastAttack = STATE.MISSILES
	start_attack_cooldown(missilesCooldown)

func start_attack_cooldown(value):
	AttackCooldown_timer.wait_time = value
	AttackCooldown_timer.one_shot = true
	AttackCooldown_timer.start()

func _on_AttackCooldownTimer_timeout():
	canAttack = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "hit"):
		hitted = false

func choose_state():
	if hitted:
		if amount >= HP:
			set_state_idle()
			current_state = STATE.DIED
		else:
			current_state = STATE.HIT
	elif canAttack:
		if lastAttack == STATE.LAVASTOMP:
			current_state = STATE.SHOTGUN
		elif lastAttack == STATE.SHOTGUN:
			current_state = STATE.MISSILES
		elif lastAttack == STATE.MISSILES:
			current_state = STATE.LAVASTOMP
	elif !canAttack:
		current_state = STATE.IDLE
