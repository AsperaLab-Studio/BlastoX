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

enum STATE {IDLE, CHASE, SHOTGUN, LAVASTOMP, PUNCH, HIT, DIED}

export var GENERAL_VARS := "--------------------"
export(int) var death_speed := 150
export(int) var move_speed := 150
export(int) var dps_shotgun := 2
export(int) var dps_lavastomp := 3
export(int) var dps_punch := 1
export(int) var hp := 5
export var wait_time_attack := 2

export var SHOTGUN_VARS := "--------------------"
export(int) var numberOfBullets
export(float) var shootingAmplitude
onready var spawnRifle : Position2D = $PositionRifle
export(PackedScene) var bullet

export var ATTACKS_VARS := "--------------------"
export(int) var dps := 10
export(int) var HP := 5
export(PackedScene) var vine_spear
export(float) var shooot_delay
onready var spear_list_pos: Array = get_parent().get_parent().get_node("spearZones").get_children()
onready var cooldown: Timer = $Cooldown

var current_state = STATE.IDLE
var actual_target: Player = null
var directionPlayer = Vector2()
var near_player: bool = false
var healthBar = null
var amount = 0
var paused = false
var areaCollided = null
var targetList = null
var actual_dps
var direction : Vector2 
var movement

var targetPos: Vector2
var oneTime = false
var jumpPos: Vector2

var sceneManager = null

var gp: Vector2

func _ready():
	anim_player.play("idle")
	healthBar = UIHealthBar
	
	sceneManager = get_parent().get_parent()

func _process(_delta: float) -> void:
	gp = global_position
	actual_target = select_target()
	
	if(!paused):

		match current_state:
			STATE.IDLE:
				anim_player.play("idle")
				current_state = STATE.PUNCH
			STATE.CHASE:
				anim_player.play("move")
				if !near_player:
					move_towards(actual_target.global_position, move_speed)
				else:
					current_state = STATE.WAIT

			STATE.HIT:
				anim_player.play("hit")

			STATE.PUNCH:
				if near_player:
					anim_player.play("punch")
				
				near_player = false
					
				if anim_player.current_animation != "punch":
					current_state = STATE.IDLE

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
	if amount >= hp:
		current_state = STATE.DIED
	else:
		current_state = STATE.HIT


func move_towards(target: Vector2, speed):
	if target:
		flip_sprite(target)
				
		var velocity = global_position.direction_to(target)
		move_and_slide(velocity * speed)


func move_sprint(_movement):
	global_position += _movement


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


func attack():
	for area in attack_area2d.get_overlapping_areas():
		if area.owner.is_in_group("player"):
			actual_target.hit(actual_dps, "melee", self)

func death():
	queue_free()


func pause():
	anim_player.stop()
	set_process(false)


func choose_array_numb(array):
	return array[randi() % array.size()]		

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hit":
		current_state = STATE.IDLE

func _on_AttackCollision_area_entered(area):
	if area.owner.is_in_group("player") && current_state == STATE.SPRINT:
		current_state = STATE.ATTACK
		near_player = true
