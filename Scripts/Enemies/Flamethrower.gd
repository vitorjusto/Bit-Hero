extends CharacterBody2D


@onready var timer = MAXTIMER
const MAXTIMER = 150
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var ani: Sprite2D = get_node("Flametrhower")

@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")

var projTimer = 10
var offsetAngule = 0
var offsetAnguleSpeed = 0.1

func _physics_process(delta: float) -> void:
	projTimer -= delta * 60
	ani.flip_h = player.position.x < position.x
	
	if projTimer <= 0:
		projTimer = 10
		ShootProjectile(offsetAngule)
		offsetAngule += offsetAnguleSpeed
		if abs(offsetAngule) == 0.7:
			offsetAnguleSpeed *= -1

func ShootProjectile(offset: float):
	
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle + offset) * -10, cos(angle + offset) * -10)

	projManager.ShootFireProjectile(global_position, speed)
