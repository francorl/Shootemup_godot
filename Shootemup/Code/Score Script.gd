extends Node2D

@onready var Background = get_node("Background")




var Score = 0
var Coin = 0

func _ready():

	$Test/UI/Retry.hide()
	
	
	
	var respawn_events = InputMap.action_get_events("Respawn")
	var respawn_event = respawn_events[0]
	var button_name = OS.get_keycode_string(respawn_event.physical_keycode)
	
	var retry_label = $Test/UI/Retry/Label
	retry_label.text = "Press to retry"
	

func _process(_delta):
	
	$Test/UI.get_node("Score").set("text", "Score: " + str(Score) + "\nCoins: " + str(Coin))
	
		



	
