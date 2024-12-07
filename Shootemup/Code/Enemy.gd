extends CharacterBody2D

@export_group("Stats")
@export var speed = 100.0
@export var health: int = 1
@export var min_damage = 1
@export var max_damage = 5
@export var damage_interval = 1  
@export_group("Player Things")
@export var player_name = "Character"
var player

@onready var absolute_parent = get_parent()
@export var score_value = 1

@onready var damage_area = $Area2D  
@onready var timer = $Timer 


var target_velocity: Vector2 = Vector2.ZERO 

func _ready():
	if absolute_parent.get_node_or_null(player_name) != null:
		player = absolute_parent.get_node(player_name)
	
	timer.wait_time = damage_interval
	timer.one_shot = false
	timer.stop()

func _physics_process(delta):
	if player != null:
	
		self.look_at(player.position)
		#self.velocity = Vector2(0, 0)
		#self.position.x = move_toward(self.position.x, player.get("position").x, speed * delta)
		#self.position.y = move_toward(self.position.y, player.get("position").y, speed * delta)
		var direction = (player.position - self.position).normalized() 
		target_velocity = direction * speed

		self.velocity = self.velocity.lerp(target_velocity, 0.1)

		move_and_collide(velocity * delta)

func _on_area_detector_body_entered(body: Node2D) -> void:
	if body.name == player_name and body.get("die") != true:
		var damage = randi_range(min_damage, max_damage)
		player.Hit(damage)
		timer.start()	

func _on_area_detector_body_exited(body: Node2D) -> void:
	if body.name == player_name:
		timer.stop()

func _on_timer_timeout():
	if player != null and player.get("die") != true:
		var damage = randi_range(min_damage, max_damage)
		player.Hit(damage)


func hit():
	health -= 1
	if health <= 0:
		absolute_parent.Score += score_value
		var kill_node = get_node_or_null("Kill")
		if kill_node != null:
			kill_node.set_emitting(true)
			kill_node.get_node("Sound").play()  
			kill_node.reparent(get_parent().get_parent())
		self.queue_free()
