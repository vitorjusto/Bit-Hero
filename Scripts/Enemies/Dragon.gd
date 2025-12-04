extends CharacterBody2D

@onready var timer = MAXTIMER
const MAXTIMER = 150
@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/FireProjectile.tscn")
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var main: Main = get_tree().root.get_node("/root/Main")
@onready var parent: Node2D = get_parent()

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	
	if timer > 0:
		return
		
	timer += MAXTIMER
	ShootProjectile(0)
	ShootProjectile(0.3)
	ShootProjectile(-0.3)

func ShootProjectile(offset: float):
	
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle + offset) * -10, cos(angle + offset) * -10)
	
	var instance : FireProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.add_child(instance)
