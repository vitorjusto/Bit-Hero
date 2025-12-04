extends CharacterBody2D

@onready var timer = MAXTIMER
const MAXTIMER = 100
@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var main: Main = get_tree().root.get_node("/root/Main")
@onready var parent: Node2D = get_parent()

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	
	if timer > 0:
		return
		
	timer += MAXTIMER
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle) * -10, cos(angle) * -10)
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.add_child(instance)
