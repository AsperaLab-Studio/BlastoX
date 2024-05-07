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

func _process(_delta):
	if sprite.frame == initial_frame + 2 && spawned == false:
		collider.disabled = true
		rng = RandomNumberGenerator.new()
		randomize()
		var obj = int(rand_range(0, 2))
		if obj != 2:
			var obj_instance = powerups_list[obj].instance()
			obj_instance.transform = pos.transform
			owner.add_child(obj_instance)
			spawned = true
			static_collider.disabled = true
		

func hit(dps, type, source):
	sprite.frame = sprite.frame + dps
