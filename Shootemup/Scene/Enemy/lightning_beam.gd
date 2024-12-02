extends State

@onready var pivot = $"../../Pivot"
var can_transition: bool = false

func enter():
	super.enter()
	# Reproducir la animación de disparo
	await play_animation("ShootAnim")
	
	# Una vez finalizada la animación, ejecutar la lógica de LightningBeam
	pivot.get_node("LightningBeam2D").shoot()
	
	# Habilitar la transición tras completar todas las tareas
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

# Ajustar la rotación hacia el objetivo
func set_target():
	pivot.rotation = (owner.direction - pivot.position).angle()
	
# Transición de estado
func transition():
	# Asegurar que la transición solo ocurre cuando esté permitido
	if can_transition:
		can_transition = false  # Bloquear nuevas transiciones
		get_parent().change_state("Dash")
