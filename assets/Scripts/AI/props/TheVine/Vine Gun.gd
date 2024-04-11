class_name VineGun
extends Node2D

onready var sprite: Sprite = $Sprite
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $HitBox/CollisionShape2D
onready var position2d: Position2D = $Position2D

enum STATE {GROW, SHOOT}

export(int) var dps = 1
export(PackedScene) var bullet

var initialFrame = 0
var delay
var current_state = STATE.GROW
var timer = Timer.new()

func _ready():
	anim_player.play("growth")
	collision_shape.disabled = true
	initialFrame = sprite.frame
	timer.connect("timeout",self,"change_to_shoot")
	timer.wait_time = delay
	self.add_child(timer)


func _process(_delta):
	match(current_state):
		STATE.GROW:
			if sprite.frame == initialFrame + 1:
				collision_shape.disabled = false
		STATE.SHOOT:
			anim_player.play("shoot")
	

func change_to_shoot():
	current_state = STATE.SHOOT

func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.direction = Vector2(-1,0)
	get_parent().add_child(bullet_instance)
	bullet_instance.global_transform = position2d.global_transform


func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "growth":
		timer.start()
	if anim_name == "shoot":
		queue_free()
