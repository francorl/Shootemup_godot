extends State

@onready var pivot = $"../../Pivot"
var can_transition: bool = false

func enter():
	super.enter()

	
	await play_animation("Death")
	boss_root.deathparticle_boss()
	
	can_transition = true

# Reproducir una animación y esperar a que termine
func play_animation(anim_name):
	bossanim.play(anim_name)
	await wait_for_animation_finish()

# Esperar a que se complete la animación actual
func wait_for_animation_finish():
	await wait_until_last_frame()

# Verificar si el cuadro actual es el último de la animación
func wait_until_last_frame() -> bool:
	var total_frames = bossanim.sprite_frames.get_frame_count(bossanim.animation)
	while bossanim.frame < total_frames - 1:
		await bossanim.frame_changed
	return true

	
# Transición de estado
func transition():
	
	if can_transition:
		can_transition = false  
		print("BOSS MUERTO")
