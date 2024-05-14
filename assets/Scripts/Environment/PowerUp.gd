class_name PowerUp
extends Node2D

enum POWER_UP_TYPE {GUN, MEDIKIT}

export(POWER_UP_TYPE) var type
export(int) var amount



func _on_Area2D_area_entered(area:Area2D):
	if area.owner && area.owner.is_in_group("player"):
		match(type):
			POWER_UP_TYPE.GUN:
				pass
			POWER_UP_TYPE.MEDIKIT:
				if area.owner.current_hp + amount >= area.owner.hp:
					area.owner.current_hp = area.owner.hp
				else:
					area.owner.current_hp = area.owner.current_hp + amount
					
				area.owner.emit_signal("update_healthbar", area.owner.current_hp)
				queue_free()
		
		
