extends Node

func _on_pausa_pressed() -> void:
	get_tree().paused = true
	$PAUSA/CanvasLayer.visible = true
	$PAUSA.visible = false

func _on_volver_pressed() -> void:
	get_tree().paused = false
	$PAUSA/CanvasLayer.visible = false
	$PAUSA.visible = true


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file ("res://Scene/UI/Menu.tscn")
	
