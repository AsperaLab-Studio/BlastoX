extends Sprite

export var firstTab = ""
export var thirdTab = ""

var positions = []
var index = 0

onready var musicLabel: Label = get_parent().get_parent().get_parent().get_parent().get_node("music")
onready var sfxLabel: Label = get_parent().get_parent().get_parent().get_parent().get_node("sfx")
onready var musicSlider: HSlider = get_parent().get_parent().get_parent().get_parent().get_node("MusicSlider")
onready var sfxSlider: HSlider = get_parent().get_parent().get_parent().get_parent().get_node("SFXSlider")
onready var fullscreen: CheckBox = get_parent().get_parent().get_parent().get_parent().get_node("checkFullscreen")

func _ready():
	for node in get_parent().get_children():
		if node is Label and node.visible:
			positions.append(node)
		
	
	_set_selection(0)
	


func _set_selection(newIndex): 
	if(0 <= newIndex and newIndex < len(positions)): 
		index = newIndex
		var selectedNode = positions[index]
		
		position = Vector2(
			selectedNode.rect_position.x - (get_rect().size.x)*scale.x/2,
			selectedNode.rect_position.y + selectedNode.rect_size.y/2 - 10
		)
	

func _process(_delta): 
	if (firstTab != ""):
		match(index):
			0:
				musicLabel.visible = false
				sfxLabel.visible = false
				musicSlider.visible = false
				sfxSlider.visible = false
				
				fullscreen.visible = false
			1:
				musicLabel.visible = true
				sfxLabel.visible = true
				musicSlider.visible = true
				sfxSlider.visible = true
				
				fullscreen.visible = true
			2:
				musicLabel.visible = false
				sfxLabel.visible = false
				musicSlider.visible = false
				sfxSlider.visible = false
				
				fullscreen.visible = false
			
	else:
		match(index):
			0:
				musicLabel.visible = true
				sfxLabel.visible = true
				musicSlider.visible = true
				sfxSlider.visible = true
				
				fullscreen.visible = true
			1:
				musicLabel.visible = false
				sfxLabel.visible = false
				musicSlider.visible = false
				sfxSlider.visible = false
				
				fullscreen.visible = false
			
	
	if get_parent().get_parent().get_parent().get_parent().visible == true:
		if Input.is_action_just_pressed("move_up"):
			_set_selection(index - 1)
		if Input.is_action_just_pressed("move_down"):
			_set_selection(index + 1)
		
	if Input.is_action_just_pressed("ui_accept"):
		if (firstTab != ""):
			if index == 0:
				get_tree().change_scene("res://scenes/" + firstTab + ".tscn")
			
			if index == 2:
				get_tree().change_scene("res://scenes/" + thirdTab + ".tscn")
			
			if index == 3:
				get_tree().quit()
			
		else:
			if index == 1:
				get_tree().change_scene("res://scenes/" + thirdTab + ".tscn")
			
			if index == 2:
				get_tree().quit()
			
		
	


func _on_SFXSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value);

func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value);

func _on_checkFullscreen_toggled(_button_pressed: bool) -> void:
	OS.window_fullscreen = !OS.window_fullscreen
