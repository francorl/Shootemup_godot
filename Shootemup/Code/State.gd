extends Node2D

class_name State
 
@onready var debug = owner.find_child("debug")
@onready var player = owner.get_parent().find_child("player")
@export var player_name = "Character"
@onready var boss_root = $"../.."

@onready var animation_player = owner.find_child("AnimationPlayer")
@onready var bossanim	= owner.find_child("BossAnim") 


@onready var player_node = get_node(player_name)

var health_zero: bool = false

func _process(delta: float) -> void:
	if boss_root.health == 0:
		health_zero = true



func _ready():
	set_physics_process(false)
 
func enter():
	set_physics_process(true)
 
func exit():
	set_physics_process(false)
 
func transition():
	pass
 
func _physics_process(_delta):
	transition()
	debug.text = name
 
