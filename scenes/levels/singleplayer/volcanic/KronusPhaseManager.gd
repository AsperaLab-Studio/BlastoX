extends Node

export(PackedScene) var kronus2
export(PackedScene) var kronus3

func change_phase(position):
	#var boss_instance = newPhase.instance()
	#add_child(boss_instance)
	#boss_instance.global_position = position
	get_child(1).visible = true
	get_child(1).global_position = position

func _on_KronusBoss_hasDied():
	var spawnPos = get_child(0).global_position
	get_child(0).visible = false
	change_phase(spawnPos)


func _on_KronusBoss2_hasDied():
	pass # Replace with function body.
