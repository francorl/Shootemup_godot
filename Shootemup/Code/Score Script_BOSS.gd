extends Node2D

#@onready var Background = get_node("Background")



@onready var character = $Character
var Score = 0
var Coin = 0
var map_size = Vector2(1000, 1000)

func _ready():

	$RETRY/Retry.hide()
	
	var respawn_events = InputMap.action_get_events("Respawn")
	var respawn_event = respawn_events[0]
	var button_name = OS.get_keycode_string(respawn_event.physical_keycode)
	
	var retry_label = $RETRY/Retry/Label
	retry_label.text = "Has Muerto"
	StarsBackground.emitting = true
	
	

func _process(_delta):
	$SCORE.get_node("Score").set("text", "Score: " + str(Score) + "\nCoins: " + str(Coin))
  # Actualiza la posición del personaje en el shader
	
