class_name JuicyBar
extends Control

@export var top_layer_bar: TextureProgressBar  # Representa la capa superior (Progress)
@export var bottom_layer_bar: TextureProgressBar  # Representa la capa inferior (Under)

@export var min_value: float = 0.0
@export var max_value: float = 100.0
@export var current_value: float = 100.0

@export var top_layer_bar_time: float = 0.2
@export var top_layer_bar_delay: float = 0.0

@export var bottom_layer_bar_time: float = 0.4
@export var bottom_layer_bar_delay: float = 0.1

@export var top_layer_progress_texture: Texture2D  # Textura para la barra de progreso superior
@export var bottom_layer_under_texture: Texture2D  # Textura para la barra inferior

# Inicialización al entrar en el árbol de escena
func _ready() -> void:
	current_value = max_value

	
	if bottom_layer_under_texture:
		bottom_layer_bar.texture_under = bottom_layer_under_texture
	if top_layer_progress_texture:
		top_layer_bar.texture_progress = top_layer_progress_texture

	
	set_progress_bar_default_values(top_layer_bar)
	set_progress_bar_default_values(bottom_layer_bar)


func set_progress_bar_default_values(bar: TextureProgressBar):
	bar.min_value = min_value
	bar.max_value = max_value
	bar.value = current_value


func change_current_value(value: float):
	current_value = clamp(value, min_value, max_value)
	run_juicy_tween(top_layer_bar, current_value, top_layer_bar_time, top_layer_bar_delay)
	run_juicy_tween(bottom_layer_bar, current_value, bottom_layer_bar_time, bottom_layer_bar_delay)


func run_juicy_tween(bar: TextureProgressBar, value: float, length: float, delay: float):
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", value, length).set_delay(delay)
