class_name DamageableObj
extends Node2D

onready var sprite: Sprite = $Sprite
onready var collider: CollisionShape2D = $Sprite/Area2D/CollisionShape2D
onready var static_collider: CollisionShape2D = $Sprite/StaticBody2D/CollisionShape2D
onready var pos: Position2D = $Position2D
export(int) var hp_box := 2
export(Array, PackedScene) var powerups_list

var initial_frame
var rng
var spawned: bool = false

func _ready():
	initial_frame = sprite.frame
	rng = RandomNumberGenerator.new()

func _process(_delta):
	if sprite.frame == initial_frame + 2 && spawned == false:
		collider.disabled = true
		rng.randomize()
		var obj = int(rand_range(0, 5))
		if obj < powerups_list.size():
			var obj_instance = powerups_list[obj].instance()
			obj_instance.position = pos.position
			add_child(obj_instance)
			spawned = true	
			static_collider.disabled = true
			print("spawned")
		

func hit(dps, _type, _source):
	sprite.frame = sprite.frame + dps
