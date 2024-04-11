class_name BulletGrenade
extends Node2D

var velocity = Vector2.ZERO
var direction: Vector2

export(int) var speed: int = 700
export(int) var damage: int = 1
export(String) var target

func _process(delta: float) -> void:
	pass


func _on_BulletArea_area_entered(area):
	if area.owner.is_in_group(target):
		var enemy = area.owner
		enemy.hit(damage, self)
		$BulletArea.monitorable = false
		queue_free()

func _on_Timer_timeout():
	queue_free()
