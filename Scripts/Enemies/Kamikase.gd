extends CharacterBody2D

var angle = 0
var isIdling = true
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var hurtbox: Hurtbox = get_node("Hurtbox")
@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var main: Main = get_tree().root.get_node("/root/Main")

func _physics_process(delta: float) -> void:
	if isIdling:
		return
	
	velocity += Vector2(sin(angle) * -1300, cos(angle) * -1300) * delta
	if move_and_slide():
		hurtbox.DefeatEnemy()
		

func onDefeat() -> void:
	shoot(0)
	shoot(30)
	shoot(60)
	shoot(90)
	shoot(120)
	shoot(150)
	shoot(180)
	shoot(210)
	shoot(240)
	shoot(270)
	shoot(300)
	shoot(330)

func shoot(angle: float):
	var speed = Vector2(sin(deg_to_rad(angle)) * -10, cos(deg_to_rad(angle)) * -10)
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.add_child(instance)

func onPlayerDetected(body: Node2D) -> void:
	angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	isIdling = false
