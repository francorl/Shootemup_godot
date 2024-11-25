extends ProgressBar

#func _ready() -> void:
	#await get_tree().create_timer(0.5).timeout
	#change_health(10)

func change_health(damage: int):
	var tween = create_tween()
	tween.tween_property(self, "value", value - damage, 0.4)
	
