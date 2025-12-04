extends CharacterBody2D

@onready var timer = MAXTIMER
const MAXTIMER = 10
@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var main: Main = get_tree().root.get_node("/root/Main")
@onready var parent: Node2D = get_parent()
var shootAngle = 0

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	
	if timer > 0:
		return
		
	timer += MAXTIMER
	
	shoot(shootAngle)
	shoot(360-shootAngle)
	shootAngle += 10
	if shootAngle == 360:
		shootAngle = 0

func shoot(angle: float):
	var speed = Vector2(sin(deg_to_rad(angle)) * -10, cos(deg_to_rad(angle)) * -10)
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.add_child(instance)
