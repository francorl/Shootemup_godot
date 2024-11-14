extends Control

func _ready():
	$PAUSA/CanvasLayer/VBoxContainer/Masterslider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$PAUSA/CanvasLayer/VBoxContainer/MUSICSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$PAUSA/CanvasLayer/VBoxContainer/SFXSlider3.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	
func _on_pausa_pressed() -> void:
	get_tree().paused = true
	$PAUSA/CanvasLayer.visible = true
	$PAUSA.visible = false

func _on_volver_pressed() -> void:
	get_tree().paused = false
	$PAUSA/CanvasLayer.visible = false
	$PAUSA.visible = true
	AudioServer.set_bus_volume_db(0, linear_to_db($PAUSA/CanvasLayer/VBoxContainer/Masterslider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($PAUSA/CanvasLayer/VBoxContainer/MUSICSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($PAUSA/CanvasLayer/VBoxContainer/SFXSlider3.value))


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file ("res://Scene/UI/Menu.tscn")
	
	
func _on_masterslider_mouse_exited():
	release_focus()
func _on_music_slider_mouse_exited():
	release_focus()
func _on_sfx_slider_3_mouse_exited():
	release_focus()
