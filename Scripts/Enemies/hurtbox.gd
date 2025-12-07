class_name Hurtbox
extends Area2D

@export var Hp = 0
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var particle : PackedScene = load("res://Scenes/Particles/Particle.tscn")
@onready var main : Main = get_tree().root.get_node("/root/Main")

signal onDefeat

func OnProjDetected(body: Node2D) -> void:
	if body is SpecialBase:
		var special : SpecialBase = body
		Hp -= special.damage
		special.emit_signal("onEnemyDeteced")
	else:
		Hp -= upgradeManager.Power
		if not upgradeManager.projPiercing:
			body.call_deferred("queue_free")
	
	GenerateParticles()
	if Hp <= 0:
		DefeatEnemy()

func DefeatEnemy():
	GenerateParticles()
	emit_signal("onDefeat")
	GeneratePowerUp()
	get_parent().call_deferred("queue_free")

func GenerateParticles():
	InstantiateParticle()
	InstantiateParticle()
	InstantiateParticle()
	InstantiateParticle()
	InstantiateParticle()
	InstantiateParticle()

func InstantiateParticle():
	var instance : Node2D = particle.instantiate()
	instance.position = get_parent().position + get_parent().get_parent().position
	main.call_deferred("add_child", instance)

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
