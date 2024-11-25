extends Node

func _ready():
	StarsBackground.emitting = true

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file ("res://Scene/UI/Play.tscn")


func _on_nivel_1_pressed() -> void:
	await Fade.fade_out(1, Color.BLACK, "", false, true).finished
	get_tree().change_scene_to_file ("res://Scene/Levels/Nivel_1.tscn")
	Fade.fade_in(1, Color.BLACK, "", false, true)
