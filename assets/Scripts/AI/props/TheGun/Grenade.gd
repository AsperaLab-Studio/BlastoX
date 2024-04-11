class_name Grenade
extends TurianWeapon

export(int) var zonesAmount = 4
export(int) var explosionDamage = 1

var total_impact_zones: Array
var rng

func _ready():
	rng = RandomNumberGenerator.new()

func shoot(player):
	var impactZones: Array
	var tmpList := total_impact_zones
	for n in zonesAmount:
		randomize()
		var randomPos = int(rand_range(0, tmpList.size()-1))
		impactZones.append(tmpList[randomPos])
		tmpList.remove(randomPos)

	for n in zonesAmount:
		(impactZones[n] as ImpactZone).activate(explosionDamage)

	# var bullet_instance = bullet.instance()
	# get_parent().get_parent().get_parent().get_parent().add_child(bullet_instance)
	# bullet_instance.set_global_position(position2d.get_global_position())
