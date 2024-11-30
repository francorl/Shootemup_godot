extends State

#idle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func enter():
	super.enter()
	#await play_animation("IdleAnim")
	
	
	
 
#func play_animation(anim_name):
		#bossanim.play(anim_name)
	
	
var player_entered: bool = false:
	set(value):
		player_entered = value
		#collision.set_deferred("disabled", value)
		
func transition():
	if player_entered:
		get_parent().change_state("LightningBeam")
 

func _on_area_detector_body_entered(body):
	player_entered = true
