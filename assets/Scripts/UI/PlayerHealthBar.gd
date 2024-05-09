extends Node2D

onready var healthbar = $Blasto/HealthBar
onready var healthbar2 = $Ceru/HealthBar
#healthbar.value = healthbar.value - amount


func _on_Blasto_update_healthbar(amount):
	healthbar.value = amount


func _on_Ceru_Star_update_healthbar(amount):
	healthbar2.value = amount
