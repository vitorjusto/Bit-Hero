extends CharacterBody2D

enum EFACINGDIRECTION {UP, DOWN, LEFT, RIGHT}
enum ESHOOTTYPE {UNI, TRI, PENTA, HEPTA}

@export var facingDirection: EFACINGDIRECTION
@export var ShootType: ESHOOTTYPE
var fixedSpeed = 7000
const JUMP_VELOCITY = -400.0

var shootTimer = 40

@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var main: Main = get_tree().root.get_node("/root/Main")
@onready var parent: Node2D = get_parent()

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
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speedproj
	instance.position = global_position
	
	main.add_child(instance)
