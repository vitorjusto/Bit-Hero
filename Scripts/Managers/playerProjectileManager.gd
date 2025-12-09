class_name PlayerProjectileManager
extends Node2D

@export var player : Player
@onready var proj : PackedScene = load("res://Scenes/Player/PlayerProjectile.tscn")
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var hud : Hud = get_tree().root.get_node("/root/Main/Hud")
@onready var availableProjectile : Array[PlayerProjectile]

var projCooldown = 0

func _ready() -> void:
	
	for i in range(0, 200):
		addProj()

func addProj() -> PlayerProjectile:
	var instance : PlayerProjectile = proj.instantiate()
	add_child(instance)
	availableProjectile.append(instance)
	return instance

func _process(delta: float) -> void:
	
	if projCooldown > 0:
		projCooldown -= delta * 60
		if projCooldown < 0:
			projCooldown = 0
		hud.updateProjCooldown(projCooldown, upgradeManager.ProjCoolDown)
		return
	
	hud.updateProjCooldown(projCooldown, upgradeManager.ProjCoolDown)
	
	if upgradeManager.AutoShoot:
		if Input.is_action_pressed("Shoot"):
			HandleProjectiles()
	else:
		if Input.is_action_just_pressed("Shoot"):
			HandleProjectiles()
		

func HandleProjectiles():
	if not player.allowMove:
		return
	
	projCooldown = upgradeManager.ProjCoolDown
	if upgradeManager.bulletAmount == 1:
		ShootProjectile(0)
	elif upgradeManager.bulletAmount == 2:
		ShootProjectile(0.1)
		ShootProjectile(-0.1)
	elif upgradeManager.bulletAmount == 3:
		ShootProjectile(0.4)
		ShootProjectile(0)
		ShootProjectile(-0.4)
	elif upgradeManager.bulletAmount == 4:
		ShootProjectile(0.05)
		ShootProjectile(-0.05)
		ShootProjectile(0.2)
		ShootProjectile(-0.2)
	elif upgradeManager.bulletAmount == 5:
		ShootProjectile(0.4)
		ShootProjectile(0)
		ShootProjectile(-0.4)
		ShootProjectile(0.2)
		ShootProjectile(-0.2)

func ShootProjectile(offSetangle : float):
	var inactive = availableProjectile.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addProj()
		
	var mouse_pos = get_viewport().get_mouse_position()
	
	#Get relative position from player according to viewport
	var playerGlobalPosition = player.get_global_transform_with_canvas().origin
	instance.position = player.position
	
	var angle = atan2(playerGlobalPosition.x - (mouse_pos.x + 16), playerGlobalPosition.y - (mouse_pos.y + 16))
	instance.SPEED = Vector2(sin(angle + offSetangle) * -80000, cos(angle + offSetangle) * -80000)
	instance.powerModifier = 1
	instance.setActive(true)

func ShootSpecialProjectile(pos: Vector2, angle: float):
	var inactive = availableProjectile.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addProj()
		
	instance.position = pos
	
	var rad = deg_to_rad(angle)
	instance.SPEED = Vector2(sin(rad) * -50000, cos(rad) * -50000)
	instance.powerModifier = 3
	
	instance.setActive(true)
