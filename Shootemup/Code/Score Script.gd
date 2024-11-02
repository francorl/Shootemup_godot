extends Node2D

@onready var Background = get_node("Background")




var Score = 0
var Coin = 0

func _ready():
	#Hide Retry UI on Start
	$Test/UI/Retry.hide()
	
	
	#Get "Respawn" mapping name
	var respawn_events = InputMap.action_get_events("Respawn")
	var respawn_event = respawn_events[0]
	var button_name = OS.get_keycode_string(respawn_event.physical_keycode)
	#Update Label to use mapping name
	var retry_label = $Test/UI/Retry/Label
	retry_label.text = "DALE FRANCO PONETE LAS PILAS"

func _process(_delta):
	# This can always be changed.
	$Test/UI.get_node("Score").set("text", "Score: " + str(Score) + "\nCoins: " + str(Coin))
	
		



	


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file ("res://Scene/MENU.tscn")
