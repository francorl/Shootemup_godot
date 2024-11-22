extends Node2D

#@onready var Background = get_node("Background")




var Score = 0
var Coin = 0

func _ready():

	$RETRY/Retry.hide()
	
	var respawn_events = InputMap.action_get_events("Respawn")
	var respawn_event = respawn_events[0]
	var button_name = OS.get_keycode_string(respawn_event.physical_keycode)
	
	var retry_label = $RETRY/Retry/Label
	retry_label.text = "Toca para Jugar de nuevo"
	retry_label.text = "Tus Puntos"
	StarsBackground.emitting = true
	
	

func _process(_delta):
	$SCORE.get_node("Score").set("text", "Score: " + str(Score) + "\nCoins: " + str(Coin))
	$RETRY/Retry.get_node("Score").set("text", "Score: " + str(Score) + "\nCoins: " + str(Coin))



	
