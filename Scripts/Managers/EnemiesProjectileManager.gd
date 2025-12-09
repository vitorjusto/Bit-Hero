class_name  EnemiesProjectileManager
extends Node2D

@onready var fireProjScene : PackedScene = load("res://Scenes/Enemies/Projectiles/FireProjectile.tscn")
@onready var fireProjs : Array[FireProjectile]

@onready var projScene : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var projs : Array[RegularEnemyProjectile]

@onready var timedProjScene : PackedScene = load("res://Scenes/Enemies/Projectiles/TimedRegularEnemyProjectile.tscn")
@onready var timedProjs : Array[TimedRegularEnemyProjectile]

func _ready() -> void:
	
	for i in range(0, 200):
		addFireProjectile()

	for i in range(0, 200):
		addRegularProjectile()

	for i in range(0, 200):
		addTimedRegularProjectile()

func addFireProjectile() -> FireProjectile:
	var instance : FireProjectile = fireProjScene.instantiate()
	add_child(instance)
	fireProjs.append(instance)

	return instance

func addRegularProjectile() -> RegularEnemyProjectile:
	var instance : RegularEnemyProjectile = projScene.instantiate()
	add_child(instance)
	projs.append(instance)

	return instance

func addTimedRegularProjectile() -> TimedRegularEnemyProjectile:
	var instance : TimedRegularEnemyProjectile = timedProjScene.instantiate()
	add_child(instance)
	timedProjs.append(instance)

	return instance

func ShootFireProjectile(pos: Vector2, speed: Vector2):
	
	var inactive = fireProjs.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addFireProjectile()
	
	instance.SPEED = speed
	instance.position = pos
	instance.setActive(true)

func ShootRegularProjectile(pos: Vector2, speed: Vector2):
	
	var inactive = projs.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addRegularProjectile()
	
	instance.SPEED = speed
	instance.position = pos
	instance.setActive(true)

func ShootTimedRegularProjectile(pos: Vector2, speed: Vector2, time: float):
	
	var inactive = timedProjs.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addTimedRegularProjectile()
	
	instance.SPEED = speed
	instance.position = pos
	instance.time = time
	instance.setActive(true)

func disableAllProjectiles():
	for i in fireProjs:
		i.setActive(true)
	for i in projs:
		i.setActive(true)
	for i in timedProjs:
		i.setActive(true)
