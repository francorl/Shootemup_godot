extends Control


func _ready():
	#StarsBackground.StarFieldMid.emmiting = true
	#StarsBackground.get_node("StarFieldMid").emmiting = true
	StarsBackground.emitting = true
	#StarsBackground.get_node("StarFieldMid").emmiting = true

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file ("res://Scene/UI/Play.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/UI/Options.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()
