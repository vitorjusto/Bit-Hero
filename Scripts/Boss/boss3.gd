class_name Boss3
extends CharacterBody2D

var SPEED = Vector2(10000, 10000)
@onready var ani: AnimationPlayer = get_node("AniSpacing")
@onready var hurtbox: Hurtbox = get_node("Hurtbox")
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var parent: Node2D = get_parent()
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@export var portal: Node2D

var timer = 100
const MAXTIMER = 60
func _physics_process(delta: float) -> void:
	if hurtbox.Hp < 2000:
		ani.play("new_animation_2")
	
	velocity = SPEED * delta

	move_and_slide()
	
	if is_on_floor() or is_on_ceiling():
		SPEED *= Vector2(1, -1)
	if is_on_wall():
		SPEED *= Vector2(-1, 1)
	
	timer -= delta * 60
	if timer > 0:
		return
	
	timer += MAXTIMER

	ShootProjectile(0)
	ShootProjectile(0.25)
	ShootProjectile(-0.25)
	ShootProjectile(0.5)
	ShootProjectile(-0.5)

func ShootProjectile(offset: float):
	
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle + offset) * -10, cos(angle + offset) * -10)
	
	projManager.ShootRegularProjectile(global_position, speed)

func onDefeat() -> void:
	portal.set_deferred("position", Vector2(640.0, 520.0))
