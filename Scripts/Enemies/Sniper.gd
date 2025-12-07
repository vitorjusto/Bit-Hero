extends CharacterBody2D

@onready var timer = MAXTIMER
const MAXTIMER = 100
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()
@onready var spr : Sprite2D = get_node("Sniper")
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	spr.flip_h = player.position.x < position.x
	
	if timer > 0:
		return
	
	timer += MAXTIMER
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle) * -10, cos(angle) * -10)
	
	projManager.ShootRegularProjectile(global_position, speed)
