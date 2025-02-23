extends Node2D

@export var flashes := 3 # Número de flashes
@export var flash_time := 0.1 # Duración entre flashes
@export var bounces_max := 3 # Máximo de rebotes
@export var lightning_jolt: PackedScene = preload("res://Scene/LightningBeam/LightningJolt.tscn")
@export var player_name = "Character" # Nombre del jugador
@export var max_distance := 300 # Máxima distancia del rayo

var target_position: Vector2 = Vector2.ZERO # Posición global del objetivo
@onready var jump_area: Area2D = $JumpArea

func _physics_process(delta) -> void:
	# Actualizar la posición del punto objetivo
	if has_collision():
		target_position = get_collision_point()
	else:
		# Si no hay colisión, el rayo apunta a su distancia máxima
		target_position = global_position + (transform.x * max_distance)

	jump_area.global_position = target_position

func has_collision() -> bool:
	# Simula si hay una colisión
	# Devuelve true si hay un objeto que interrumpe el rayo (este método debe ser implementado).
	# Si usas `Physics2DDirectSpaceState`, implementa las consultas.
	return false

func get_collision_point() -> Vector2:
	# Devuelve el punto de colisión si el rayo colisiona
	# Esto también debe implementar lógica de colisión (por ejemplo, usando `intersect_ray`).
	return global_position

func shoot() -> void:
	var start_point = global_position
	var direction = (target_position - start_point).normalized()
	var current_bounces = 0

	# Repite el disparo según la cantidad de flashes
	for flash in range(flashes):
		# Disparar el primer rayo desde el origen
		shoot_ray(start_point, direction, current_bounces)

		# Esperar entre flashes
		await get_tree().create_timer(flash_time).timeout

func shoot_ray(start_point: Vector2, direction: Vector2, current_bounces: int) -> void:
	var _start = start_point
	var _direction = direction
	var _bounces = current_bounces

	# Procesar rebotes
	while _bounces <= bounces_max:
		# Calcular el punto final del rayo según la distancia máxima
		var end_point = _start + _direction * max_distance
		var collision_point = end_point
		var collided = false

		# Simula si el rayo colisiona con algo (por ejemplo, usando `Physics2DDirectSpaceState`)
		if has_collision():
			collision_point = get_collision_point()
			collided = true

		# Crear un rayo desde el punto inicial hasta el punto de colisión
		create_lightning(_start, collision_point)

		if collided:
			# Obtener normal de colisión y calcular el rebote
			var collision_normal = Vector2.UP # Reemplazar con la normal real de la colisión
			_direction = _direction.bounce(collision_normal)
			_bounces += 1

			# Aplicar daño al cuerpo colisionado
			var collider = null # Reemplazar con el objeto colisionado real
			if collider and collider is PhysicsBody2D:
				if collider.has_method("HitBossLightning"):
					collider.HitBossLightning()
				else:
					apply_damage(collider)

			_start = collision_point
		else:
			# Si no hay colisión, termina el rayo
			break

func create_lightning(start: Vector2, end: Vector2) -> void:
	# Crear una instancia del rayo y configurarlo
	var jolt = lightning_jolt.instantiate()
	add_child(jolt)
	jolt.create(start, end)

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
