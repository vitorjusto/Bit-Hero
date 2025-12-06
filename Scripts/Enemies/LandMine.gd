extends Area2D

@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var main: Main = get_tree().root.get_node("/root/Main")

func onDefeat() -> void:
	shoot(0)
	shoot(10)
	shoot(20)
	shoot(30)
	shoot(40)
	shoot(50)
	shoot(60)
	shoot(70)
	shoot(80)
	shoot(90)
	shoot(100)
	shoot(110)
	shoot(120)
	shoot(130)
	shoot(140)
	shoot(150)
	shoot(160)
	shoot(170)
	shoot(180)
	shoot(190)
	shoot(200)
	shoot(210)
	shoot(220)
	shoot(230)
	shoot(240)
	shoot(250)
	shoot(260)
	shoot(270)
	shoot(280)
	shoot(290)
	shoot(300)
	shoot(310)
	shoot(320)
	shoot(330)
	shoot(340)
	shoot(350)

func shoot(angle: float):
	var speed = Vector2(sin(deg_to_rad(angle)) * -10, cos(deg_to_rad(angle)) * -10)
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.call_deferred("add_child", instance)

func onPlayerDetected(body: Node2D) -> void:
	var hurtbox : Hurtbox = get_node("Hurtbox")
	hurtbox.DefeatEnemy()
