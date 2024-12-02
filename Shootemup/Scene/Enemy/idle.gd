extends State

var can_transition: bool = false


func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	pass
	

#
#func enter():
	#super.enter()
	#await play_animation("IdleAnim")
	#can_transition = true
	#
	#
 #
#func play_animation(anim_name):
	#bossanim.play(anim_name)
	#await wait_for_animation_finish()
	#
	#
#func wait_for_animation_finish():	
	#return await wait_until_last_frame()	
	#
	#
#func wait_until_last_frame() -> bool:
#
	#var total_frames = bossanim.sprite_frames.get_frame_count(bossanim.animation)
	#while bossanim.frame < total_frames - 1:
		#await bossanim.frame_changed  
	#return true  	
	#
	
var player_entered: bool = false:
	set(value):
		player_entered = value
	
func transition():
	if player_entered:
		get_parent().change_state("LightningBeam")
		
 

func _on_area_detector_body_entered(body):
	player_entered = true
