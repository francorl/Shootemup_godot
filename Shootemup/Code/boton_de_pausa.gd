extends Node

func _on_menu_pressed() -> void:
	get_tree().paused = true
	$MENU/Popup.visible = true
	$MENU.visible = false



func _on_button_pressed() -> void:
	get_tree().paused = false
	$MENU/Popup.visible = false
	$MENU.visible = true
