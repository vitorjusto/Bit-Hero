extends CharacterBody2D

enum EFACINGDIRECTION {UP, DOWN, LEFT, RIGHT}
enum ESHOOTTYPE {UNI, TRI, PENTA, HEPTA}

@export var facingDirection: EFACINGDIRECTION
@export var ShootType: ESHOOTTYPE
var fixedSpeed = 7000
const JUMP_VELOCITY = -400.0

var shootTimer = 40

@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var parent: Node2D = get_parent()
@onready var ani: AnimatedSprite2D = get_node("AniBody")
@onready var cannon: Sprite2D = get_node("RegularShooter")

func _ready():
	if facingDirection == EFACINGDIRECTION.UP:
		ani.play("Up")
		cannon.z_index = -1
		cannon.offset = Vector2(8, -12)
		cannon.rotation_degrees = 270
	if facingDirection == EFACINGDIRECTION.DOWN:
		ani.play("Down")
		cannon.offset = Vector2(16, -12)
		cannon.rotation_degrees = 90
	if facingDirection == EFACINGDIRECTION.LEFT:
		ani.play("Left")
		cannon.offset = Vector2(-12, -7)
		cannon.flip_h = true
	if facingDirection == EFACINGDIRECTION.RIGHT:
		ani.play("Right")
		cannon.offset = Vector2(12, -7)

func _physics_process(delta: float) -> void:
	shootTimer -= delta * 60
	if shootTimer <= 0:
		if facingDirection == EFACINGDIRECTION.UP:
			shoot(0)
			if ShootType == ESHOOTTYPE.TRI:
				shoot(-10)
				shoot(10)
			if ShootType == ESHOOTTYPE.PENTA:
				shoot(-10)
				shoot(10)
				shoot(-20)
				shoot(20)
			if ShootType == ESHOOTTYPE.HEPTA:
				shoot(-10)
				shoot(10)
				shoot(-20)
				shoot(20)
				shoot(-30)
				shoot(30)
				
		if facingDirection == EFACINGDIRECTION.DOWN:
			shoot(180)
			if ShootType == ESHOOTTYPE.TRI:
				shoot(170)
				shoot(190)
			if ShootType == ESHOOTTYPE.PENTA:
				shoot(170)
				shoot(190)
				shoot(160)
				shoot(200)
			if ShootType == ESHOOTTYPE.HEPTA:
				shoot(170)
				shoot(190)
				shoot(160)
				shoot(200)
				shoot(150)
				shoot(210)
		if facingDirection == EFACINGDIRECTION.LEFT:
			shoot(90)
			if ShootType == ESHOOTTYPE.TRI:
				shoot(80)
				shoot(100)
			if ShootType == ESHOOTTYPE.PENTA:
				shoot(80)
				shoot(100)
				shoot(70)
				shoot(110)
			if ShootType == ESHOOTTYPE.HEPTA:
				shoot(80)
				shoot(100)
				shoot(70)
				shoot(110)
				shoot(60)
				shoot(120)
		if facingDirection == EFACINGDIRECTION.RIGHT:
			shoot(270)
			if ShootType == ESHOOTTYPE.TRI:
				shoot(260)
				shoot(280)
			if ShootType == ESHOOTTYPE.PENTA:
				shoot(260)
				shoot(280)
				shoot(250)
				shoot(290)
			if ShootType == ESHOOTTYPE.HEPTA:
				shoot(260)
				shoot(280)
				shoot(250)
				shoot(290)
				shoot(240)
				shoot(300)
			
		shootTimer = 40

func shoot(angle: float):
	var speedproj = Vector2(sin(deg_to_rad(angle)) * -10, cos(deg_to_rad(angle)) * -10)
	
	projManager.ShootRegularProjectile(global_position, speedproj)
