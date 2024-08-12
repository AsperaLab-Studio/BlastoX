class_name kronusBoss3
extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var pivot: Node2D = $Pivot
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $Pivot/HitBox/CollisionShape2D
onready var collision_shape_body : CollisionShape2D = $CollisionShape2D
onready var collition_area2d : CollisionShape2D = $Pivot/AttackCollision/CollisionShape2D
onready var attack_area2d : Area2D = $Pivot/AttackCollision
onready var UIHealthBar: Node2D = $UI/HealthContainer
onready var cooldown: Timer = $Cooldown
onready var invincibility_timer = $InvincibilityTimer
onready var attack_delay_timer: Timer = $AttackDelayTimer

enum STATE {IDLE, CHASE, SHOTGUN, LAVASTOMP, PUNCH, HIT, DIED, BACKJUMP}

export var GENERAL_VARS := "--------------------"
export(int) var death_speed := 150
export(int) var move_speed := 150
export(int) var hp := 5
export(float) var wait_attack := 2.0
export(float) var range_chase := 2.0

export var SHOTGUN_VARS := "--------------------"
export(int) var dps_shotgun := 2
export(int) var numberOfBullets  := 5
export(float) var shootingAmplitude  := 30.0
onready var spawnRifle : Position2D = $Pivot/PositionRifle
export(PackedScene) var bullet

export var LAVA_STOMP_VARS := "--------------------"
export(int) var dps_lavastomp := 3
export(PackedScene) var lava_column
onready var lava_column_list_pos: Array = get_parent().get_parent().get_node("spearZones").get_children()
onready var lava_container: Node = get_node("LavaColumnContainer")
var temp_list: Array
var onEnter = true
var rng

export var PUNCH_VARS := "--------------------"
export(int) var dps_punch := 1

var current_state = STATE.IDLE
var actual_target: Player = null
var directionPlayer = Vector2()

var BACK_JUMP := "--------------------"
onready var boss_list_points: Array = get_parent().get_parent().get_node("bossPoints").get_children()
var targetBackJump
export(int) var back_speed := 250

var STATE_FLAGS := "--------------------"
var near_player: bool = false
var ended_punch: bool = false
var hitted: bool = false
var can_ranged: bool = false
var is_ranged: bool = false
var ended_back: bool = true
var bullet_right: bool = false
var previous_state 
var invincible: bool = false
var canPunch: bool = false

var healthBar = null
var amount = 0
var paused = false
var targetList = null
var direction : Vector2 
var prevRangedState : int = STATE.LAVASTOMP

var sceneManager = null

var gp: Vector2

func _ready():
	anim_player.play("idle")
	healthBar = UIHealthBar
	
	rng = RandomNumberGenerator.new()
	sceneManager = get_parent().get_parent()

func _process(_delta: float) -> void:
	gp = global_position
	actual_target = select_target()
	
	previous_state = current_state
	choose_state()

	if(!paused):

		match current_state:
			STATE.IDLE:
				if near_player:
					anim_player.play("idle")
					if attack_delay_timer.is_stopped():
						attack_delay_timer.wait_time = 1
						attack_delay_timer.start()
				else:
					anim_player.play("idle")

			STATE.HIT:
				anim_player.play("hit")

			STATE.CHASE:
				anim_player.play("chase")
				if !near_player:
					move_towards(actual_target.global_position, move_speed)

			STATE.BACKJUMP:
				anim_player.play("lavastomp")
				if onEnter:
					var d1 = abs(actual_target.global_position.x - boss_list_points[0].global_position.x)
					var d2 = abs(actual_target.global_position.x - boss_list_points[1].global_position.x)

					if d1 <= d2:
						targetBackJump = boss_list_points[1].global_position
					else:
						targetBackJump = boss_list_points[0].global_position

					onEnter = false
				else:
					var velocity = global_position.direction_to(targetBackJump)
					move_and_slide(velocity * back_speed)
				
				if global_position.distance_to(targetBackJump) < 5:
					ended_back = true
					onEnter = true

			STATE.PUNCH:
				if near_player && !actual_target.invincible:
					anim_player.play("punch")
					
				if anim_player.current_animation != "punch":
					ended_punch = true

			STATE.SHOTGUN:
				anim_player.play("shotgun")

			STATE.LAVASTOMP:
				var actual_zone: int

				if onEnter == true:
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
					cooldown.wait_time = wait_attack
					cooldown.start()
					can_ranged = false
					is_ranged = false
					onEnter = true

			STATE.DIED:
				collision_shape_body.disabled = true
				collision_shape.disabled = true
				collition_area2d.disabled = true
				
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
	healthBar.update_healthbar(dpsTaken)
	amount = amount + dpsTaken
	if invincible == false:	
		hitted = true
	


func move_towards(target: Vector2, speed):
	if target:
		flip_sprite(target)
				
		var velocity = global_position.direction_to(target)
		move_and_slide(velocity * speed)


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
			bullet_right = false
		elif velocity.x > 0:
			sprite.flip_h = false
			if pivot.scale.x < 0:
				pivot.scale.x = - pivot.scale.x
			bullet_right = true



func attack():
	for area in attack_area2d.get_overlapping_areas():
		if area.owner.is_in_group("player"):
			actual_target.hit(dps_punch, "melee", self)
			canPunch = false


func shoot():
	var deltaAngle = shootingAmplitude/(numberOfBullets -1)
	var directionRifle = spawnRifle.get_global_position().direction_to(actual_target.global_position)
	var angle = -sign(directionRifle.y) * acos(abs(directionRifle.x))
	
	var i = 0
	for n in numberOfBullets:
		var bullet_instance = bullet.instance()
		if bullet_right:
			bullet_instance.rotation_degrees = 0
		else:
			bullet_instance.rotation_degrees = 180
		var angleOffset = shootingAmplitude/2 - deltaAngle * i
		bullet_instance.rotate(angle + deg2rad(angleOffset))
		bullet_instance.direction = Vector2(cos(bullet_instance.rotation), sin(bullet_instance.rotation))
		get_parent().get_parent().get_parent().get_parent().add_child(bullet_instance)
		bullet_instance.set_global_position(spawnRifle.get_global_position())
		i+=1
	
	cooldown.wait_time = wait_attack
	cooldown.start()
	can_ranged = false
	is_ranged = false


func death():
	queue_free()


func pause():
	anim_player.stop()
	set_process(false)


func choose_array_numb(array):
	return array[randi() % array.size()]		

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hit":
		hitted = false

func _on_AttackCollision_area_entered(area):
	if area.owner.is_in_group("player"):
		near_player = true
		canPunch = true

func _on_AttackCollision_area_exited(area:Area2D):
	if area.owner.is_in_group("player"):
		near_player = false
		canPunch = false

func _on_Cooldown_timeout():
	can_ranged = true

func _on_AnimationPlayer_animation_started(anim_name:String):
	if anim_name == "hit":
		invincibility_timer.start(1)
		invincible = true

func _on_InvincibilityTimer_timeout():
	invincible = false
	
func _on_AttackDelayTimer_timeout():
	canPunch = true

func choose_state():
	if !can_ranged:
		current_state = STATE.IDLE
	if hitted:
		if amount >= hp:
			current_state = STATE.DIED
		else:
			current_state = STATE.HIT

		if is_ranged == true:
			is_ranged = false
		if onEnter == false:
			onEnter = true
	elif near_player:
		if canPunch:
			current_state = STATE.PUNCH
		else:
			current_state = STATE.IDLE
	elif !near_player:
		var distance = global_position.distance_to(actual_target.global_position)
		if distance <= range_chase:
			current_state = STATE.CHASE
			is_ranged = false
			onEnter = true
		else:
			if previous_state != STATE.CHASE && ended_back:
				if can_ranged && (current_state != STATE.SHOTGUN || current_state != STATE.LAVASTOMP):
					if !is_ranged:
						is_ranged = true
						if prevRangedState == STATE.LAVASTOMP:
							current_state = STATE.SHOTGUN
							prevRangedState = STATE.SHOTGUN
						else:
							current_state = STATE.LAVASTOMP
							prevRangedState = STATE.LAVASTOMP
			else:
				ended_back = false
				current_state = STATE.BACKJUMP

