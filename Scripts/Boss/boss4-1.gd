extends CharacterBody2D

enum EFACINGDIRECTION {UP, DOWN, LEFT, RIGHT}

var facingDirection: EFACINGDIRECTION
var speed = Vector2(0, 0)
var fixedSpeed = 7000
const JUMP_VELOCITY = -400.0
var walkingCicle = 0

var shootTimer = 80
var fireTimer = 90
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var parent: Node2D = get_parent()
@onready var ani : AnimationPlayer = get_node("AnimationPlayer")
@onready var spr : Sprite2D = get_node("Boss4Wizard")

func _physics_process(delta: float) -> void:
	IdleAround(delta)
	handleRegularProjectile(delta)
	HandleFireProjectile(delta)
	

func handleRegularProjectile(delta: float):
	shootTimer -= delta * 60
	if shootTimer <= 0:
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
		shootTimer = 50
		
func HandleFireProjectile(delta: float):
	fireTimer -= delta * 60
	if fireTimer <= 0:
		ShootFireProjectile(0)
		ShootFireProjectile(0.2)
		ShootFireProjectile(-0.2)
		ShootFireProjectile(0.4)
		ShootFireProjectile(-0.4)
		fireTimer = 80
	
func IdleAround(delta: float):
	walkingCicle -= delta * 60
	velocity = speed * delta
	spr.flip_h = velocity.x < 0
	
	if move_and_slide():
		walkingCicle = 0
	
	if walkingCicle <= 0:
		var rng = randi_range(0, 3)
		if rng == 0:
			facingDirection = EFACINGDIRECTION.LEFT
			speed = Vector2(fixedSpeed, 0)
		if rng == 1:
			facingDirection = EFACINGDIRECTION.RIGHT
			speed = Vector2(-fixedSpeed, 0)
		if rng == 2:
			facingDirection = EFACINGDIRECTION.DOWN
			speed = Vector2(0, fixedSpeed)
		if rng == 3:
			facingDirection = EFACINGDIRECTION.UP
			speed = Vector2(0, -fixedSpeed)
		walkingCicle = 100

func shoot(angle: float):
	var speedproj = Vector2(sin(deg_to_rad(angle)) * -5, cos(deg_to_rad(angle)) * -5)
	projManager.ShootRegularProjectile(global_position, speedproj)
	




func ShootFireProjectile(offset: float):
	
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle + offset) * -10, cos(angle + offset) * -10)
	
	projManager.ShootFireProjectile(global_position, speed)

func onDefeated() -> void:
	set_physics_process(false)
	ani.play("new_animation")

signal onFirstFaseDefeated()

func onAnimationFinished(anim_name: StringName) -> void:
	emit_signal("onFirstFaseDefeated")
	call_deferred("queue_free")
