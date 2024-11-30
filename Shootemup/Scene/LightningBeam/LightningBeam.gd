extends RayCast2D

@export var flashes := 3 # Número de flashes
@export var flash_time := 0.1 # Duración entre flashes
@export var bounces_max := 3 # Máximo de rebotes
@export var lightning_jolt: PackedScene = preload("res://Scene/LightningBeam/LightningJolt.tscn")
@export var player_name = "Character" # Nombre del jugador

var target_point := Vector2.ZERO  # Posición global donde apunta el rayo.

@onready var jump_area: Area2D = $JumpArea

func _physics_process(delta) -> void:
	# Actualizar la posición del punto objetivo
	target_point = to_global(target_position)

	if is_colliding():
		target_point = get_collision_point()

	jump_area.global_position = target_point

func shoot() -> void:
	var _target_point = target_point
	var _primary_body = get_collider()

	# Daño al cuerpo principal si existe
	if _primary_body != null:
		if _primary_body.has_method("HitBossLightning"):
			_primary_body.HitBossLightning()
		else:
			print("Impacto directo en:", _primary_body)
			apply_damage(_primary_body)

	var _secondary_bodies = jump_area.get_overlapping_bodies()

	# Quitar el primario de los secundarios si está en la lista
	if _primary_body:
		_secondary_bodies.erase(_primary_body)
		_target_point = _primary_body.global_position

	for flash in range(flashes):
		var _start = global_position

		# Crear el primer rayo
		var jolt = lightning_jolt.instantiate()
		add_child(jolt)
		jolt.create(_start, target_point)

		_start = _target_point
		for _i in range(min(bounces_max, _secondary_bodies.size())):
			var _body = _secondary_bodies[_i]

			# Aplica daño o efecto a todos los cuerpos secundarios
			if _body is PhysicsBody2D:
				if _body.has_method("HitBossLightning"):
					_body.HitBossLightning()
				else:
					print("Impacto en:", _body)
					apply_damage(_body)

				# Crear el rayo al siguiente cuerpo
				jolt = lightning_jolt.instantiate()
				add_child(jolt)
				jolt.create(_start, _body.global_position)
				_start = _body.global_position

		# Daño adicional si el jugador está en el área del rayo
		for body in _secondary_bodies:
			if is_player(body):
				apply_damage(body)

		# Esperar antes del próximo flash
		await get_tree().create_timer(flash_time).timeout

func apply_damage(body: Node) -> void:
	# Lógica genérica para aplicar daño al cuerpo
	if body.get("health") != null:
		body.health -= 10  # Ajusta el valor de daño según sea necesario
		print("Daño aplicado a:", body.name, "Salud restante:", body.health)
		if body.health <= 0:
			print(body.name, "ha sido eliminado.")
			body.queue_free()  # Elimina el cuerpo si la salud llega a 0
	else:
		print("El cuerpo no tiene una propiedad 'health', no se puede aplicar daño directamente.")

func is_player(node: Node) -> bool:
	# Verifica si el nodo es el jugador
	return node.name == player_name or node.is_in_group("Player")
