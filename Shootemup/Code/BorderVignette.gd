extends ColorRect

@onready var player = get_node("/root/Game/Player") # Ajusta esta ruta a tu escena
@export var map_size: Vector2 = Vector2(1920, 1080)
@export var fade_distance: float = 400.0
@export var max_darkness: float = 0.6
@export var pulse_speed: float = 2.0
@export var pulse_intensity: float = 0.2

func _ready():
	# Configura el ColorRect para cubrir toda la pantalla
	anchor_right = 1
	anchor_bottom = 1
	
	# Crea y configura el material del shader
	material = ShaderMaterial.new()
	material.shader = preload("res://Scene/Shaders/border_vignette.gdshader")
	
	# Establece los parámetros iniciales del shader
	material.set_shader_parameter("map_size", map_size)
	material.set_shader_parameter("fade_distance", fade_distance)
	material.set_shader_parameter("max_darkness", max_darkness)

func _process(_delta):
	if player:
		material.set_shader_parameter("character_position", player.global_position)
		var base_darkness = material.get_shader_parameter("max_darkness")
		var pulse = (sin(Time.get_ticks_msec() * 0.001 * pulse_speed) * 0.5 + 0.5) * pulse_intensity
		material.set_shader_parameter("max_darkness", base_darkness + pulse)
