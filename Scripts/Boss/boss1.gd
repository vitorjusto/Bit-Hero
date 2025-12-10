extends CharacterBody2D

@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var hurtbox: Hurtbox = get_node("Hurtbox")
@export var portal: Node2D

var angle
func _ready() -> void:
	changeAngle()

func _physics_process(delta: float) -> void:
	velocity += Vector2(sin(angle) * -1000, cos(angle) * -1000) * delta
	
	if move_and_slide():
		shootAllProjectiles()
		changeAngle()
		AddVelocity()

func changeAngle():
	velocity = Vector2.ZERO
	angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)

func AddVelocity():

	if is_on_wall_only():
		velocity += Vector2(200 if position.x < 500 else -200, 0)
	elif is_on_ceiling_only():
		velocity += Vector2(0, 200)
	elif is_on_floor_only():
		velocity += Vector2(0, -200)
		

func shootAllProjectiles():
	shoot(0)
	shoot(20)
	shoot(40)
	shoot(60)
	shoot(80)
	shoot(100)
	shoot(120)
	shoot(140)
	shoot(160)
	shoot(180)
	shoot(200)
	shoot(220)
	shoot(240)
	shoot(260)
	shoot(280)
	shoot(300)
	shoot(320)
	shoot(340)

	var rng = randi_range(1, 30)
	if rng == 1:
		shoot(10)
		shoot(30)
		shoot(50)
		shoot(70)
		shoot(90)
		shoot(110)
		shoot(130)
		shoot(150)
		shoot(170)
		shoot(190)
		shoot(210)
		shoot(230)
		shoot(250)
		shoot(270)
		shoot(290)
		shoot(310)
		shoot(330)
		shoot(350)
	


func shoot(ang: float):
	var speed = Vector2(sin(deg_to_rad(ang)) * -10, cos(deg_to_rad(ang)) * -10)
	projManager.ShootRegularProjectile(global_position, speed)

func onDefeat() -> void:
	portal.set_deferred("position", Vector2(640.0, 520.0))
