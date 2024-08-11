class_name KronusMissile
extends Node2D
signal HasShootMissile

var position2d : Position2D
export(PackedScene) var bullet
	
func shoot(player):
	var playerRef := player as Player
	var bullet_instance = bullet.instance()
	
	var t1 = playerRef.global_position
	var t2 = position2d.get_global_position().direction_to(playerRef.global_position)
	var direction = Vector2((t1.x - t2.x), (t1.y - t2.y)).normalized()
	
	var numerator = (direction.x * t1.x + direction.y * t1.y)
	var denominator = (sqrt(powFunctionSum(direction.x, direction.y, 2)) * sqrt( powFunctionSum(t1.x, t1.y, 2)))
	var angle = acos(numerator / denominator)
	
	#bullet_instance.rotate(deg2rad(t2.angle()))
	bullet_instance.rotation = t2.angle()
	bullet_instance.direction = t2
	get_parent().get_parent().get_parent().get_parent().add_child(bullet_instance)
	bullet_instance.set_global_position(position2d.get_global_position())
	emit_signal("HasShootMissile")

func powFunctionSum(value1 : float, value2 : float, base : float) -> float:
	return (pow(value1, base) + pow(value2, base))

