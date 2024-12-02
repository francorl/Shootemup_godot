extends Node2D

@export var flashes := 3
@export var flash_time := 0.1
@export var bounces_max := 3 
@export var lightning_jolt: PackedScene = preload("res://Scene/LightningBeam/LightningJolt.tscn")
@export var player_name = "Character" # 
@export var max_distance := 300 # 

var target_position: Vector2 = Vector2.ZERO 
@onready var jump_area: Area2D = $JumpArea

func _physics_process(delta) -> void:
 
	if has_collision():
		target_position = get_collision_point()
	else:
	
		target_position = global_position + (transform.x * max_distance)

	jump_area.global_position = target_position

func has_collision() -> bool:
 
 
 
	return false

func get_collision_point() -> Vector2:
 
	return global_position

func shoot() -> void:
	var start_point = global_position
	var direction = (target_position - start_point).normalized()
	var current_bounces = 0

	# 
	for flash in range(flashes):
		# 
		shoot_ray(start_point, direction, current_bounces)

		# 
		await get_tree().create_timer(flash_time).timeout

func shoot_ray(start_point: Vector2, direction: Vector2, current_bounces: int) -> void:
	var _start = start_point
	var _direction = direction
	var _bounces = current_bounces

	#
	while _bounces <= bounces_max:
		#
		var end_point = _start + _direction * max_distance
		var collision_point = end_point
		var collided = false

		
		if has_collision():
			collision_point = get_collision_point()
			collided = true

		
		create_lightning(_start, collision_point)

		if collided:
			
			var collision_normal = Vector2.UP 
			_direction = _direction.bounce(collision_normal)
			_bounces += 1

			
			var collider = null
			if collider and collider is PhysicsBody2D:
				if collider.has_method("HitBossLightning"):
					collider.HitBossLightning()
				else:
					apply_damage(collider)

			_start = collision_point
		else:
			
			break

func create_lightning(start: Vector2, end: Vector2) -> void:
	
	var jolt = lightning_jolt.instantiate()
	add_child(jolt)
	jolt.create(start, end)

func apply_damage(body: Node) -> void:
	
	if body.get("health") != null:
		body.health -= 10  
		print("Daño aplicado a:", body.name, "Salud restante:", body.health)
		if body.health <= 0:
			print(body.name, "ha sido eliminado.")
			body.queue_free()  
	else:
		print("El cuerpo no tiene una propiedad 'health', no se puede aplicar daño directamente.")

func is_player(node: Node) -> bool:
	
	return node.name == player_name or node.is_in_group("Player")
