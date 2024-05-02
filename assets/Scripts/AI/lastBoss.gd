class_name LastBoss
extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var pivot: Node2D = $Pivot
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $HitBox/CollisionShape2D
onready var collision_shape_body : CollisionShape2D = $CollisionShape2D
onready var UIHealthBar: Node2D = get_parent().get_parent().get_parent().get_node("GUI/UI/HealthBossContainer")
onready var camera: Camera2D = get_parent().get_parent().get_parent().get_node("Camera2D")
enum STATE {IDLE, HIT, DIED, STOMP, SHOTGUN, MISSILES}

export(int) var dps := 10
export(int) var HP := 5

var current_state = STATE.CHASE
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
	anim_player.play("idle")
	healthBar = UIHealthBar
	
	sceneManager = get_parent().get_parent()
	

func _process(_delta: float) -> void:
	actual_target = select_target()
	
	if(!paused):
		match current_state:
			
			STATE.HIT:
				anim_player.play("hit")
				
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
		

