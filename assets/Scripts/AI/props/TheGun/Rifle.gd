class_name Rifle
extends TurianWeapon

export(int) var numberOfBullets
export(float) var shootingAmplitude

func shoot(player):
	var deltaAngle = shootingAmplitude/(numberOfBullets -1)
	var playerRef := player as Player
	var direction = position2d.get_global_position().direction_to(playerRef.global_position)
	var angle = -sign(direction.y) * acos(abs(direction.x))
	
	# var numerator = (direction.x * t1.x + direction.y * t1.y)
	# var denominator = (sqrt(powFunctionSum(direction.x, direction.y, 2)) *sqrt( powFunctionSum(t1.x, t1.y, 2)))
	# var angle = acos(numerator / denominator) 
	
	var i = 0
	for n in numberOfBullets:
		var bullet_instance = bullet.instance()
		var angleOffset = shootingAmplitude/2 - deltaAngle * i
		bullet_instance.rotate(angle + deg2rad(angleOffset))
		bullet_instance.direction = Vector2(cos(bullet_instance.rotation), sin(bullet_instance.rotation))
		get_parent().get_parent().get_parent().get_parent().add_child(bullet_instance)
		bullet_instance.set_global_position(position2d.get_global_position())
		i+=1


