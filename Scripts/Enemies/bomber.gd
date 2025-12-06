extends CharacterBody2D

var bombtimer = 200
var followingPlayer = false

@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var main: Main = get_tree().root.get_node("/root/Main")

@onready var hurtbox : Hurtbox = get_node("Hurtbox")
@onready var ani : AnimatedSprite2D = get_node("AnimatedSprite2D")
var walkingCicle = 0
var speed = Vector2(0, 0)
var fixedSpeed = 4000

func _physics_process(delta: float) -> void:
	if followingPlayer:
		FollowPlayer(delta)
	else:
		IdleAround(delta)

func IdleAround(delta: float):
	walkingCicle -= delta * 60
	velocity = speed * delta
	
	if move_and_slide():
		speed *= -1
	
	if walkingCicle <= 0:
		if speed == Vector2.ZERO:
			var rng = randi_range(0, 3)
			if rng == 0:
				speed = Vector2(fixedSpeed, 0)
			if rng == 1:
				speed = Vector2(-fixedSpeed, 0)
			if rng == 2:
				speed = Vector2(0, fixedSpeed)
			if rng == 3:
				speed = Vector2(0, -fixedSpeed)
			walkingCicle = 300
			ani.play("Walking")
		else:
			speed = Vector2.ZERO
			walkingCicle = 100
			ani.play("Idle")

func FollowPlayer(delta: float):
	ani.play("Anger")
	ani.speed_scale = 4
	
	bombtimer -= delta * 60
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	velocity = Vector2(sin(angle) * -20000, cos(angle) * -20000) * delta
	
	move_and_slide()
	
	if (bombtimer <= 0):
		hurtbox.DefeatEnemy()

func onPlayerDetected(body: Node2D) -> void:
	followingPlayer = true

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
	
