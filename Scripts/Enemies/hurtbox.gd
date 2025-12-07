class_name Hurtbox
extends Area2D

@export var Hp = 0
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var main : Main = get_tree().root.get_node("/root/Main")
@onready var particleManager : ParticleManager = get_tree().root.get_node("/root/Main/ParticleManager")

signal onDefeat

func OnProjDetected(body: Node2D) -> void:
	if body is SpecialBase:
		var special : SpecialBase = body
		Hp -= special.damage
		special.emit_signal("onEnemyDeteced")
	else:
		var proj : PlayerProjectile = body
		Hp -= upgradeManager.Power * proj.powerModifier

		if not upgradeManager.projPiercing:
			proj.setActive(false) 
	
	GenerateParticles()
	if Hp <= 0:
		DefeatEnemy()

func DefeatEnemy():
	GenerateParticles()
	emit_signal("onDefeat")
	GeneratePowerUp()
	get_parent().call_deferred("queue_free")

func GenerateParticles():
	particleManager.AddParticles(get_parent().position + get_parent().get_parent().position, 3)

func GeneratePowerUp():
	var rng = randi_range(0, 100)
	
	if rng < 20:
		if not upgradeManager.EnemiesDropsHP:
			return
		var hpUp : PackedScene = load("res://Scenes/PowerUps/HpUp.tscn")
		var instance : Node2D = hpUp.instantiate()
		instance.position = get_parent().position + get_parent().get_parent().position
		main.call_deferred("add_child", instance)
	elif rng < 40:
		if not upgradeManager.EnemiesDropsSpecial:
			return
		var spUp : PackedScene = load("res://Scenes/PowerUps/SpecialUp.tscn")
		var instance : Node2D = spUp.instantiate()
		instance.position =get_parent().position + get_parent().get_parent().position
		main.call_deferred("add_child", instance)
	elif rng < 60:
		if not upgradeManager.EnemiesDropsSpecial:
			return
		var tmUp : PackedScene = load("res://Scenes/PowerUps/TimeUp.tscn")
		var instance : Node2D = tmUp.instantiate()
		instance.position =get_parent().position + get_parent().get_parent().position
		main.call_deferred("add_child", instance)
	elif rng < 65:
		if not upgradeManager.EnemiesDropsLife:
			return
		var spUp : PackedScene = load("res://Scenes/PowerUps/LifeUp.tscn")
		var instance : Node2D = spUp.instantiate()
		instance.position = get_parent().position + get_parent().get_parent().position
		main.call_deferred("add_child", instance)
