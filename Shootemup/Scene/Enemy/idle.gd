extends State

var can_transition: bool = false


	
	
func enter():
	super.enter()
	await play_animation("IdleAnim")
	can_transition = true
	
	
 
func play_animation(anim_name):
	bossanim.play(anim_name)
	await wait_for_animation_finish()
	
	
func wait_for_animation_finish():
	await wait_until_last_frame()
	
	
func wait_until_last_frame() -> bool:
	var total_frames = bossanim.sprite_frames.get_frame_count(bossanim.animation)
	while bossanim.frame < total_frames - 1:
		await bossanim.frame_changed
	return true
	
var player_entered: bool = false:
	set(value):
		player_entered = value
	
func transition():
	match true:
		
		player_entered:
			get_parent().change_state("LightningBeam")
			player_entered = false
		
	
		can_transition:
			can_transition = false  
			get_parent().change_state("LightningBeam")
		
		# Caso 3: Si la salud es 0
		health_zero:
			can_transition = false 
			get_parent().change_state("Death")

func _on_area_detector_body_entered(body):
	player_entered = true
