extends CharacterBody2D



@onready var Camera = get_node("Camera2D")
@onready var absolute_parent = get_parent()

@export var Bullet: PackedScene
@export var joystick_left: VirtualJoystick
@export var joystick_right: VirtualJoystick
@export var speed: float = 100
@export var fire_rate = 0.2

const SPEED = 300.0


var power = false
var weapon = false
var respawn = false
var die: bool = false


var shoot_direction = Vector2.ZERO
var move_vector := Vector2.ZERO
var weapon_timer = 0
var power_timer = 0
var respawn_timer = 0
var actual_rate = 0.2
var timer = 0











	
func _ready():
	
	Camera.set("position", Vector2(100, 0))


func _process(delta: float) -> void:
	move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += move_vector * speed * delta


	
	if joystick_right and joystick_right.is_pressed:
		rotation = joystick_right.output.angle()
		

		
func _physics_process(delta):
	
	
	timer += delta
	
	if joystick_right and joystick_right.is_pressed:
		
		shoot_direction = joystick_right.output.normalized()
	else:
		shoot_direction = Vector2(cos(rotation), sin(rotation)).normalized()
		#Descomentar para PC con mouse
		#shoot_direction = (get_global_mouse_position() - global_position).normalized()
		

#TIMERS

	if power:
		power_timer += delta
		actual_rate = fire_rate / 2
		if power_timer >= 10:
			power = false
			power_timer = 0
	else:
		actual_rate = fire_rate
		
		
	if weapon:
		weapon_timer += delta
		if weapon_timer >= 5:
			weapon = false
			weapon_timer = 0
			print("Weapon Deactivated")
			
######################################################




	if die:
		if respawn:
			respawn_timer += delta
			if respawn_timer >= 1:
				if Input.get_action_raw_strength("Respawn"):
					Respawn()
					respawn = false
				return
########################################################

	# Disparo.
	if timer >= actual_rate:
		timer = 0
		var bullet_instance = Bullet.instantiate()
		add_sibling(bullet_instance)
		bullet_instance.global_position = get_node("BulletSpawn").global_position
		bullet_instance.set("area_direction", shoot_direction)  
		bullet_instance.rotation = shoot_direction.angle()
		
		if weapon:
		
			var bullet_instance2 = Bullet.instantiate()
			add_sibling(bullet_instance2)
			bullet_instance2.global_position = get_node("BulletSpawn").global_position
			bullet_instance2.set("area_direction", shoot_direction.rotated(deg_to_rad(15)))
			bullet_instance2.rotation = shoot_direction.rotated(deg_to_rad(15)).angle() 
			print("Weapon Activated")

		
		Camera.offset = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	else:
		Camera.offset = Vector2(0, 0)
	

	#Descomentar para PC con mouse
	#self.look_at(get_global_mouse_position())
	move_and_slide()

func Die():
	get_node("Explosive").set_emitting(true)
	get_node("Explosive/Sound").play()
	get_node("MeshInstance2D").visible = false
	Camera.position = Vector2(0, 0)
	die = true
	respawn = true
	position = Vector2(383, 397)
	joystick_left.visible = false
	joystick_right.visible = false
	joystick_right.reset
	$"../RETRY/Retry".show()

func Respawn():
	get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	
	printerr("Timer Stop")
	weapon = false
	print("Weapon Deactivated")
	$Timer.stop()
