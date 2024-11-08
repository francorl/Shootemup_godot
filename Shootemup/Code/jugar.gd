extends Control



func _ready():
	StarsBackground.emitting = true

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file ("res://Scene/MENU.tscn")


func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file ("res://Scene/main_scene.tscn")
