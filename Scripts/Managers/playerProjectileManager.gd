extends Node2D

@export var player : Player
@onready var proj : PackedScene = load("res://Scenes/Player/PlayerProjectile.tscn")
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var hud : Hud = get_tree().root.get_node("/root/Main/Hud")

var projCooldown = 0

func _process(delta: float) -> void:
	
	if projCooldown > 0:
		projCooldown -= delta * 60
		if projCooldown < 0:
			projCooldown = 0
		hud.updateProjCooldown(projCooldown, upgradeManager.ProjCoolDown)
		return
	
	hud.updateProjCooldown(projCooldown, upgradeManager.ProjCoolDown)
	if Input.is_action_just_pressed("Shoot"):
		HandleProjectiles()

func HandleProjectiles():
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
		ShootProjectile(0.1)
		ShootProjectile(-0.1)
		ShootProjectile(0.3)
		ShootProjectile(-0.3)
	elif upgradeManager.bulletAmount == 5:
		ShootProjectile(0.4)
		ShootProjectile(0)
		ShootProjectile(-0.4)
		ShootProjectile(0.2)
		ShootProjectile(-0.2)

func ShootProjectile(offSetangle : float):
	var instance : PlayerProjectile = proj.instantiate()
	instance.position = player.position
	
	var mouse_pos = get_viewport().get_mouse_position()
	
	#Get relative position from player according to viewport
	var playerGlobalPosition = player.get_global_transform_with_canvas().origin
	
	var angle = atan2(playerGlobalPosition.x - (mouse_pos.x + 16), playerGlobalPosition.y - (mouse_pos.y + 16))
	instance.SPEED = Vector2(sin(angle + offSetangle) * -80000, cos(angle + offSetangle) * -80000)
	
	add_child(instance)
