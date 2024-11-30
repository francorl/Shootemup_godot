extends Area2D

@onready var absolute_parent = get_parent().get_node(".")

var animdelay = 0
	

func _process(delta: float) -> void:
	GlobalVariables.Score = absolute_parent.Score
	
	animdelay += delta
	
	
	if animdelay >= 5:
	
		$AnimatedSprite2D.play("CoinAnim")
		animdelay = 0
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		absolute_parent.Coin += 1
		GlobalVariables.Coin = absolute_parent.Coin
		
		#print(GlobalVariables.Coin)
	
		self.queue_free()
