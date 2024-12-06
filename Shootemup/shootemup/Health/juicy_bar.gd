extends Control

#class_name JuicyBar
 
@export var top_layer_bar : TextureProgressBar
@export var bottom_layer_bar : TextureProgressBar

@export var min_value : float 
@export var max_value: float 
@export var current_value: float

@export var top_layer_bar_time = 0.2
@export var top_layer_bar_delay = 0

@export var bottom_layer_bar_time = 0.4
@export var bottom_layer_bar_delay = 0.1


func _ready() -> void:
	current_value = max_value
	set_progress_bar_default_values(top_layer_bar)
	set_progress_bar_default_values(bottom_layer_bar)
	pass

func set_progress_bar_default_values(bar: TextureProgressBar):
	bar.min_value = min_value
	bar.max_value = max_value
	bar.value = current_value
	pass

func change_current_value(value: float):
	current_value = clamp(value, min_value, max_value)
	run_juicy_tween(top_layer_bar,current_value,top_layer_bar_time,top_layer_bar_delay)
	run_juicy_tween(bottom_layer_bar,current_value,bottom_layer_bar_time,bottom_layer_bar_delay)
	pass

func run_juicy_tween(bar: TextureProgressBar, value: float, length: float, delay: float ):
	var tween = get_tree().create_tween()
	tween.tween_property(bar,"value",value,length).set_delay(delay)
	pass


func _process(delta: float) -> void:
	pass
