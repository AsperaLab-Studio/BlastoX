extends Node

export(PackedScene) var kronus2
export(PackedScene) var kronus3
export(float) var spawnposX
export(float) var spawnposY

func change_phase(newPhase):
	var boss_instance = newPhase.instance()
	add_child(boss_instance)
	boss_instance.global_position = Vector2(spawnposX, spawnposY)
	get_parent().refill_bosses()
