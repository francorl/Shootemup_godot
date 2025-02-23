extends Area2D

@export var Coin: PackedScene

@export var PowerUp: PackedScene
@export var Weapon: PackedScene
@export var power_spawn_rate = 20

var power_timer = 0
var coinage


@onready var SquareSizeX = get_node("CollisionShape2D").get_shape().get_rect().size.x / 2
@onready var SquareSizeY = get_node("CollisionShape2D").get_shape().get_rect().size.y / 2

func _ready():
	var temp = Coin.instantiate()
	temp.position = self.position + (Vector2(randi_range(-(SquareSizeX), SquareSizeX), randi_range(-(SquareSizeY), SquareSizeY)))
	add_sibling.call_deferred(temp)
	coinage = temp
	
	

	
func _process(delta):
	power_timer += delta
	
	if power_timer >= power_spawn_rate:
		power_timer = 0
		#PowerUp
		var temp = PowerUp.instantiate()
		
		#Weapon
		var new_weapon = Weapon.instantiate()
		
		temp.position = self.position + (Vector2(randi_range(-(SquareSizeX), SquareSizeX), randi_range(-(SquareSizeY), SquareSizeY)))
		add_sibling.call_deferred(temp)
		
		
		new_weapon.position = self.position + (Vector2(randi_range(-(SquareSizeX), SquareSizeX), randi_range(-(SquareSizeY), SquareSizeY)))
		add_sibling.call_deferred(new_weapon)
		
		

	
	if coinage == null:
		_ready()
