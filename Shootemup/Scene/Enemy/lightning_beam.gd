extends State
 
@onready var pivot = $"../../Pivot"
var can_transition: bool = false

func enter():
	super.enter()
	await play_animation("ShootAnim")
	#await play_animation("laser")
	can_transition = true
 
func play_animation(anim_name):
	bossanim.play(anim_name)
	await wait_for_animation_finish()
	
func wait_for_animation_finish():	
	return await wait_until_last_frame()	
	
	
func wait_until_last_frame() -> bool:

	var total_frames = bossanim.sprite_frames.get_frame_count(bossanim.animation)
	while bossanim.frame < total_frames - 1:
		await bossanim.frame_changed  
	return true  

 
func set_target():
	pivot.rotation = (owner.direction - pivot.position).angle()
 
func transition():
	if can_transition:
		can_transition = false
	#get_parent().change_state("Idle")
