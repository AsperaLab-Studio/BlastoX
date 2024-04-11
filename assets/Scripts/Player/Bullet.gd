class_name Bullet
extends Node2D

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT

export(int) var speed: int = 700
export(int) var damage: int = 1
export(String) var target

func _process(delta: float) -> void:
	velocity.x = speed * delta 
	
	if direction == Vector2.LEFT:
		$Sprite.flip_v = true
	
	position += velocity * direction


func _on_BulletArea_area_entered(area):
	if area.owner.is_in_group(target):
		var enemy = area.owner
		enemy.hit(damage, "ranged", self)
		$BulletArea.monitorable = false
		queue_free()

func _on_Timer_timeout():
	queue_free()
