extends Control

var introfade = true
func _ready():
	StarsBackground.emitting = true	
	

func _process(delta: float) -> void:
	
	if introfade:
		await Fade.fade_in(0.5, Color.BLACK, "" ,false, true)
		introfade = false

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file ("res://Scene/UI/Play.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/UI/Options.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()
