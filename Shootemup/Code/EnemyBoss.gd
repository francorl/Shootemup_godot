extends CharacterBody2D

@export_group("Stats")
@export var speed = 100.0
@export var health: int = 1
# assigned on ready, this stops a flood of errors.
@export_group("Player Things")
@export var player_name = "Character"
@export var Loot: PackedScene
var player
# In the main scene, this goes to the very very top node! one node down, there should
# be the character and the spawners

@export var loot_count: int = 5   # Número de ítems de loot a generar
@export var loot_range: float = 100.0   # Distancia máxima alrededor de la posición para generar loot
@onready var absolute_parent = get_parent()
# Used to increase the score (Spawners should be the child of a "scene" node)
@export var score_value = 1



func _ready():
	if absolute_parent.get_node_or_null(player_name) != null:
		player = absolute_parent.get_node(player_name)

	
	
func _process(delta):
	
	
	
	# These 3 little lines of code handle movement! Don't ask me why velocity has to be set this way.
	if player != null:
		self.look_at(player.get("position"))
		self.velocity = Vector2(0, 0)
		self.position.x = move_toward(self.position.x, player.get("position").x, speed * delta)
		self.position.y = move_toward(self.position.y, player.get("position").y, speed * delta)
	
	move_and_slide()

# Destroy the player
func _on_area_detector_body_entered(body):
	if body.name == player_name && body.get("die") != true:
		body.Die()

# Get hit, or die.
func hit():
	health -= 1
	if health == 0:
		
		absolute_parent.Score += score_value
		
		
		#Spawn Loot
		for i in loot_count:
			var temp = Loot.instantiate()
			var offset_x = randf_range(-loot_range, loot_range)
			var offset_y = randf_range(-loot_range, loot_range)
			temp.position = self.position + Vector2(offset_x, offset_y)
			add_sibling.call_deferred(temp)
		
		
		get_node("Kill").set_emitting(true)
		get_node("Kill/Sound").play()
		get_node("Kill").reparent(get_parent().get_parent())
		self.queue_free()
		
