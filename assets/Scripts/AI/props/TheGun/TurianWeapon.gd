class_name TurianWeapon
extends Node2D

var position2d : Position2D
export(PackedScene) var bullet
	
func shoot(player):
	pass

func powFunctionSum(value1 : float, value2 : float, base : float) -> float:
	return (pow(value1, base) + pow(value2, base))
