extends CharacterBody2D

const SPEED = 300.0
@export var Bullet: PackedScene
@onready var Camera = get_node("Camera2D")

@export var joystick_left: VirtualJoystick
@export var joystick_right: VirtualJoystick
@export var speed: float = 100
@export var fire_rate = 0.2
var actual_rate = 0.2
var timer = 0

var power = false
var weapon = false
var weapon_timer = 0
var power_timer = 0

@onready var absolute_parent = get_parent()


var die: bool = false

var move_vector := Vector2.ZERO

func _process(delta: float) -> void:
	move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += move_vector * speed * delta


	if joystick_right and joystick_right.is_pressed:
		rotation = joystick_right.output.angle()

func _physics_process(delta):
	timer += delta


	if power:
		power_timer += delta
		actual_rate = fire_rate / 2
		if power_timer >= 10:
			power = false
			power_timer = 0
	else:
		actual_rate = fire_rate

	velocity = Vector2.ZERO

	if die:
		if Input.get_action_raw_strength("Respawn"):
			Respawn()
		return

	# Disparo.
	if timer >= actual_rate:
		var temp = Bullet.instantiate()
		add_sibling(temp)
		temp.global_position = get_node("BulletSpawn").global_position
		
		var shoot_direction = Vector2.ZERO
		if joystick_right and joystick_right.is_pressed:
			shoot_direction = joystick_right.output.normalized()
		else:
			shoot_direction = (get_global_mouse_position() - global_position).normalized()
		
		temp.set("area_direction", shoot_direction)

	
		if weapon:
			weapon_timer += delta
			var bullet2 = Bullet.instantiate()
			add_sibling(bullet2)
			bullet2.global_position = get_node("BulletSpawn").global_position

			
			var shoot_direction2 = shoot_direction.rotated(deg_to_rad(15)) 
				
			bullet2.set("area_direction", shoot_direction2)

		
			
			
			
			actual_rate = fire_rate / 2
			
			if weapon_timer >= 3:
					weapon = false
					weapon_timer = 0
			else:
					actual_rate = fire_rate

		
		if joystick_right and joystick_right.is_pressed:
			rotation = joystick_right.output.angle()
		else:
			look_at(get_global_mouse_position())

		
		Camera.offset = Vector2(randf_range(-1, 1), randf_range(-1, 1))
		timer = 0
	else:
		Camera.offset = Vector2(0, 0)

	
	var direction_x = Input.get_axis("Left", "Right")
	var direction_y = Input.get_axis("Up", "Down")
	
	if direction_x:
		velocity.x = direction_x * SPEED
	if direction_y:
		velocity.y = direction_y * SPEED

	move_and_slide()

func Die():
	get_node("Explosive").set_emitting(true)
	get_node("Explosive/Sound").play()
	get_node("MeshInstance2D").visible = false
	Camera.position = Vector2(0, 0)
	die = true
	await get_tree().create_timer(1.5).timeout
	position = Vector2(383, 397)
	joystick_left.visible = false
	joystick_right.visible = false
	$"../Retry".show()

func Respawn():
	get_tree().reload_current_scene()
