extends CharacterBody2D

@onready var timer = MAXTIMER
const MAXTIMER = 150
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var parent: Node2D = get_parent()
@onready var ani: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	ani.flip_h = player.position.x < position.x
	
	if timer > 0:
		return
	
	timer += MAXTIMER

	ShootProjectile(0)
	ShootProjectile(0.3)
	ShootProjectile(-0.3)

func ShootProjectile(offset: float):
	
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle + offset) * -10, cos(angle + offset) * -10)
	
	projManager.ShootFireProjectile(global_position, speed)
