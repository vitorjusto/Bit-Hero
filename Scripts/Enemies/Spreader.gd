extends CharacterBody2D


enum ESHOOTTYPE {SPREAD, SPREADER}
@export var ShootType : ESHOOTTYPE

@onready var timer = MAXTIMER
const MAXTIMER = 80
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	
	if timer > 0:
		return
		
	timer += MAXTIMER
	
	if ShootType == ESHOOTTYPE.SPREAD:
		shoot(0)
		shoot(45)
		shoot(90)
		shoot(135)
		shoot(180)
		shoot(225)
		shoot(270)
		shoot(315)
	elif ShootType == ESHOOTTYPE.SPREADER:
		shoot(0)
		shoot(15)
		shoot(30)
		shoot(45)
		shoot(60)
		shoot(75)
		shoot(90)
		shoot(105)
		shoot(120)
		shoot(135)
		shoot(150)
		shoot(165)
		shoot(180)
		shoot(195)
		shoot(210)
		shoot(225)
		shoot(240)
		shoot(255)
		shoot(270)
		shoot(285)
		shoot(300)
		shoot(315)
		shoot(330)
		shoot(345)

func shoot(angle: float):
	var speed = Vector2(sin(deg_to_rad(angle)) * -10, cos(deg_to_rad(angle)) * -10)
	projManager.ShootRegularProjectile(global_position, speed)
	