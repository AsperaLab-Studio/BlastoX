class_name kronusPhaseManager
extends Node

export(PackedScene) var kronus2
export(PackedScene) var kronus3

func change_phase(newPhase, position):
	var boss_instance = newPhase.instance()
	add_child(boss_instance)
	boss_instance.global_position = position
	get_parent().refill_bosses()

func _on_KronusBoss_hasDied():
	var spawnPos = get_child(0).global_position
	get_child(0).visible = false
	change_phase(kronus2, spawnPos)

func change_to_third_phase():
	var spawnPos = get_child(0).global_position
	get_child(0).visible = false
	change_phase(kronus3, spawnPos)
	get_parent().get_node("lava pool/floor2").visible = true
	get_parent().get_node("lava pool/StaticBody2D/CollisionShape2D").disabled = true
