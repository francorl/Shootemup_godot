extends RayCast2D  # Asegúrate de que herede correctamente.

@export var flashes := 3 # (int, 1, 10)
@export var flash_time := 0.1 # (float, 0.0, 3.0)
@export var bounces_max := 3 # (int, 0, 10)
@export var lightning_jolt: PackedScene = preload("res://Scene/LightningBeam/LightningJolt.tscn")
@export var player_name = "Character"
var player
var target_point := Vector2.ZERO  # Esta es una posición global donde apunta el rayo.

@onready var jump_area: Area2D = $JumpArea  # Confirma que JumpArea existe como nodo.

func _physics_process(delta) -> void:
	
	target_point = to_global(target_position)

	if is_colliding():
		target_point = get_collision_point()

		#var body = get_collider()
		#if body != null and body.name == player_name and body.has_method("Hit"):
			#body.HitBossLightning()  
	
	jump_area.global_position = target_point

func shoot() -> void:
	var _target_point = target_point
	var _primary_body = get_collider()

	if _primary_body != null and _primary_body.has_method("HitBossLightning"):
		print(_primary_body.get_class())
		_primary_body.HitBossLightning()
		
		
		#if _primary_body.name == player_name and _primary_body.has_method("Hit"):
			#print("Personaje encontrado, llamando a Hit()")
			#_primary_body.HitBossLightning()
	
	var _secondary_bodies = jump_area.get_overlapping_bodies()

	if _primary_body:
		_secondary_bodies.erase(_primary_body)
		_target_point = _primary_body.global_position

	for flash in range(flashes):
		var _start = global_position

		var jolt = lightning_jolt.instantiate()
		add_child(jolt)
		jolt.create(_start, target_point)

		_start = _target_point
		for _i in range(min(bounces_max, _secondary_bodies.size())):
			var _body = _secondary_bodies[_i]

			jolt = lightning_jolt.instantiate()
			add_child(jolt)
			# jolt.create(_start, _body.global_position)
			_start = _body.global_position
			
		await get_tree().create_timer(flash_time).timeout
