class_name Main
extends Node2D

var currentSection = 0
var sections = []
@onready var player : Player = get_node("Player")
@onready var wall : StaticBody2D = get_node("StaticBody2D")
@onready var blackScreen : CanvasLayer = get_node("CanvasLayer")
@onready var upgradeManager : UpgradeManager = get_node("UpgradeManager")
@onready var enemiesProj : EnemiesProjectileManager = get_node("EnemiesProjectileManager")
@onready var hud : Hud = get_node("Hud")
@onready var lblTimeUp : Label = get_node("CanvasLayer/lblTimeUp")

var level = 1
var blackScreenTimer = 100

func _ready() -> void:
	blackScreen.visible = true
	player.allowMove = false
	GenerateLevels()
	SetPlayerCameraBehavior()

func _process(delta: float) -> void:
	if blackScreenTimer <= 0:
		return
	
	blackScreenTimer -= delta *60
	
	if blackScreenTimer <= 0:
		player.process_mode = Node.PROCESS_MODE_INHERIT
		player.hp = upgradeManager.MaxHP
		blackScreen.visible = false
		player.allowMove = true
		player.visible = true
		player.aniSprite.visible = true
		player.col.set_deferred("disabled", false)
		lblTimeUp.visible = false
	
func SetPlayerCameraBehavior():
	
	var section : Node2D = sections[currentSection]
	var entraceAnchor : Node2D = section.get_children().filter(func(x)-> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.ENTRANCE).get(0)
	
	var playerCamera : Camera2D = player.get_node("Camera2D")
	playerCamera.limit_bottom = section.position.y + entraceAnchor.position.y
	playerCamera.limit_top = section.position.y

func GenerateLevels():
	currentSection = 0
	
	var scene : PackedScene = load("res://Scenes/Levels/Level1/Level1-start.tscn")
	var instance: Node2D = scene.instantiate()
	
	var lastLevel = instance
	call_deferred("add_child", instance)
	sections.append(instance)
	
	var amount = 2
	for n in range(1, amount):
		if n == amount - 1:
			scene = load("res://Scenes/Levels/Level%d/Level%d-boss.tscn" % [level, level])
		elif n % 5 == 0:
			scene = load("res://Scenes/Levels/SacrificialChamber.tscn")
		else:
			scene = load("res://Scenes/Levels/Level%d/Level%d-%d.tscn" % [level, level, randi_range(1, 10)])
		instance = scene.instantiate()
	
		var lastLevelAnchor : LevelAnchor = lastLevel.get_children().filter(func(x) -> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.EXIT).get(0)
		var currentLevelAnchor : Node2D = instance.get_children().filter(func(x)-> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.ENTRANCE).get(0)
		
		instance.position =Vector2(0, lastLevel.position.y + lastLevelAnchor.position.y - currentLevelAnchor.position.y)
		
		lastLevel = instance
		call_deferred("add_child", instance)
		sections.append(instance)
	
	if level == 4:
		scene = load("res://Scenes/Levels/Level4/Level4-finish.tscn")
		instance = scene.instantiate()
	
		var lastLevelAnchor : LevelAnchor = lastLevel.get_children().filter(func(x) -> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.EXIT).get(0)
		var currentLevelAnchor : Node2D = instance.get_children().filter(func(x)-> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.ENTRANCE).get(0)
		
		instance.position =Vector2(0, lastLevel.position.y + lastLevelAnchor.position.y - currentLevelAnchor.position.y)
		
		lastLevel = instance
		call_deferred("add_child", instance)
		sections.append(instance)

func nextSection():
	var section : Node2D = sections[1]
	wall.position = section.position
	
	currentSection += 1
	SetPlayerCameraBehavior()
	var prevSection : LevelBase = sections[0]
	prevSection.call_deferred("queue_free")
	sections.remove_at(0)

func setCamerafromStart():
	currentSection = 0
	SetPlayerCameraBehavior()

func onPlayerDied() -> void:
	player.life -= 1
	
	if player.life == 0:
		get_tree().change_scene_to_file("res://Scenes/GameOverScreen.tscn")
	blackScreen.visible = true
	blackScreenTimer = 120
	player.position = Vector2(640.0, 520.0)
	
	enemiesProj.disableAllProjectiles()
	ClearLevels()
	GenerateLevels()
	setCamerafromStart()

func ClearLevels():
	for a in sections:
		a.call_deferred("queue_free")
	
	sections.clear()

func OnTimeUp() -> void:
	lblTimeUp.visible = true

func nextLevel():
	blackScreen.visible = true
	blackScreenTimer = 120
	player.position = Vector2(640.0, 520.0)
	enemiesProj.disableAllProjectiles()
	player.allowMove = false
	level += 1
	ClearLevels()
	GenerateLevels()
	setCamerafromStart()
