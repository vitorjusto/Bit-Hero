extends CharacterBody2D

var angle = 0
var isIdling = true
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var hurtbox: Hurtbox = get_node("Hurtbox")
@onready var ani: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")

func _physics_process(delta: float) -> void:
	if isIdling:
		ani.flip_h = player.position.x < position.x
		return
	
	var speed = Vector2(sin(angle) * -1300, cos(angle) * -1300) * delta
	velocity += speed
	
	
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

func shoot(ang: float):
	var speed = Vector2(sin(deg_to_rad(ang)) * -10, cos(deg_to_rad(ang)) * -10)
	projManager.ShootRegularProjectile(global_position, speed)

func onPlayerDetected(body: Node2D) -> void:
	angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	isIdling = false
	var speed = Vector2(sin(angle), cos(angle))
	ani.rotation_degrees = rad_to_deg(speed.angle()) + 90
	ani.flip_v = true
	
	ani.flip_h = false
	ani.play("Attacking")
