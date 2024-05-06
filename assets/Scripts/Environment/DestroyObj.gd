class_name DamageableObj
extends Node2D

onready var sprite: Sprite = get_node("Sprite")
export(int) var hp_box := 2

var initial_frame

func _ready():
    initial_frame = sprite.frame

func _process(delta):
    if sprite.frame == initial_frame + 2:
        #spawn 1/3 obj
        pass 

func hit(dps, type, source):
    sprite.frame = sprite.frame + dps