class_name Hurtbox
extends Area2D

@export var Hp = 0
@export var isImortal = false
var defeated = false
var powerUpDropped = false
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var main : Main = get_tree().root.get_node("/root/Main")
@onready var powerUpManager : PowerUpManager = get_tree().root.get_node("/root/Main/PowerUpManager")
@onready var particleManager : ParticleManager = get_tree().root.get_node("/root/Main/ParticleManager")
@onready var player : Player = get_tree().root.get_node("/root/Main/Player")

signal onDefeat

func OnProjDetected(body: Node2D) -> void:
	if body is SpecialBase:
		var special : SpecialBase = body
		Hp -= special.damage
		special.emit_signal("onEnemyDeteced")
	elif body is PlayerProjectile:
		var proj : PlayerProjectile = body
		Hp -= upgradeManager.Power * proj.powerModifier

		if not upgradeManager.projPiercing:
			proj.setActive(false) 
	
	GenerateParticles()
	if Hp <= 0:
		player.Score += 100
		DefeatEnemy()

func DefeatEnemy():
	emit_signal("onDefeat")
	GenerateParticles()
	
	if not isImortal and not defeated:
		GeneratePowerUp()
		get_parent().call_deferred("queue_free")
	
	defeated = true

func GenerateParticles():
	particleManager.AddParticles(get_parent().position + get_parent().get_parent().position, 3)

func GeneratePowerUp():
	if powerUpDropped:
		return
	
	powerUpDropped = true
	var rng = randf_range(0, 100)
	
	if rng < 20:
		if not upgradeManager.EnemiesDropsHP:
			return
		var hpUp : PackedScene = load("res://Scenes/PowerUps/HpUp.tscn")
		var instance : Node2D = hpUp.instantiate()
		instance.position = get_parent().position + get_parent().get_parent().position
		powerUpManager.AddPowerUp(instance)
	elif rng < 40:
		if not upgradeManager.EnemiesDropsSpecial:
			return
		var spUp : PackedScene = load("res://Scenes/PowerUps/SpecialUp.tscn")
		var instance : Node2D = spUp.instantiate()
		instance.position =get_parent().position + get_parent().get_parent().position
		powerUpManager.AddPowerUp(instance)
	elif rng < 60:
		if not upgradeManager.EnemiesDropsSpecial:
			return
		var tmUp : PackedScene = load("res://Scenes/PowerUps/TimeUp.tscn")
		var instance : Node2D = tmUp.instantiate()
		instance.position =get_parent().position + get_parent().get_parent().position
		powerUpManager.AddPowerUp(instance)
	elif rng < 60.05:
		if not upgradeManager.EnemiesDropsLife:
			return
		var spUp : PackedScene = load("res://Scenes/PowerUps/LifeUp.tscn")
		var instance : Node2D = spUp.instantiate()
		instance.position = get_parent().position + get_parent().get_parent().position
		powerUpManager.AddPowerUp(instance)
