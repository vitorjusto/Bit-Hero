class_name Boss2
extends CharacterBody2D

enum EFACINGDIRECTION {UP, DOWN, LEFT, RIGHT}
var facingDirection: EFACINGDIRECTION

var walkingCicle = 0
var speed = Vector2(0, 0)
var fixedSpeed: float = 10000
@export var anchors : Array[Node2D]
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var hurtbox: Hurtbox = get_node("Hurtbox")
@export var portal: Node2D

var shootTimer =150
const MAXSHOOTTIMER : float = 80

func _physics_process(delta: float) -> void:
	IdleAround(delta)
	shootTimer -= delta * 60
	if shootTimer <= 0:
		shootTimer = MAXSHOOTTIMER if hurtbox.Hp > 1500 else (MAXSHOOTTIMER * 3) / 4
		Shoot()

func IdleAround(delta: float):
	walkingCicle -= delta * 60
	velocity = speed * delta
	
	if move_and_slide():
		speed *= -1
	
	if walkingCicle <= 0:
		var rng = randi_range(0, 3)
		var currentSpeed = fixedSpeed if hurtbox.Hp > 1500 else fixedSpeed * 2
		if rng == 0:
			facingDirection = EFACINGDIRECTION.LEFT
			speed = Vector2(currentSpeed, 0)
		if rng == 1:
			facingDirection = EFACINGDIRECTION.RIGHT
			speed = Vector2(-currentSpeed, 0)
		if rng == 2:
			facingDirection = EFACINGDIRECTION.DOWN
			speed = Vector2(0, currentSpeed)
		if rng == 3:
			facingDirection = EFACINGDIRECTION.UP
			speed = Vector2(0, -currentSpeed)
		walkingCicle = 40

func Shoot():
	for a in anchors:
		ShootProjectile(a.position, 0)
		ShootProjectile(a.position, 0.4)
		ShootProjectile(a.position, -0.4)

func ShootProjectile(offSetPos: Vector2, offset: float):
	var angle = 0 
	
	if offSetPos.y < -90:#Up
		angle = 0
	if offSetPos.y > 90:#Down
		angle = 180
	if offSetPos.x < -90:#Left
		angle = 90
	if offSetPos.x > 90:#Right
		angle = 270
	
	var projSpeed = Vector2(sin(deg_to_rad(angle) + offset) * -10, cos(deg_to_rad(angle) + offset) * -10)
	projManager.ShootFireProjectile(global_position + offSetPos, projSpeed)
	

func onDefeat() -> void:
	portal.set_deferred("position", Vector2(640.0, 520.0))
