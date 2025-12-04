extends CharacterBody2D

enum EFACINGDIRECTION {UP, DOWN, LEFT, RIGHT}

var facingDirection: EFACINGDIRECTION
var speed = Vector2(0, 0)
var fixedSpeed = 7000
const JUMP_VELOCITY = -400.0
var walkingCicle = 0

var shootTimer = 40

@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/TimedRegularEnemyProjectile.tscn")
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var main: Main = get_tree().root.get_node("/root/Main")
@onready var parent: Node2D = get_parent()

func _physics_process(delta: float) -> void:
	IdleAround(delta)
	
	shootTimer -= delta * 60
	if shootTimer <= 0:
		if facingDirection == EFACINGDIRECTION.UP:
			shoot(0)
		if facingDirection == EFACINGDIRECTION.DOWN:
			shoot(180)
		if facingDirection == EFACINGDIRECTION.RIGHT:
			shoot(90)
		if facingDirection == EFACINGDIRECTION.LEFT:
			shoot(270)
		shootTimer = 40

func IdleAround(delta: float):
	walkingCicle -= delta * 60
	velocity = speed * delta
	
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
	
	var instance : TimedRegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speedproj
	instance.position = global_position
	instance.time = 100
	main.add_child(instance)
