class_name Main
extends Node2D

var currentSection = 0
var sections = []
@onready var player : Player = get_node("Player")
@onready var wall : StaticBody2D = get_node("StaticBody2D")

func _ready() -> void:
	GenerateLevels()
	SetPlayerCameraBehavior()

func SetPlayerCameraBehavior():
	
	var section : Node2D = sections[currentSection]
	var entraceAnchor : Node2D = section.get_children().filter(func(x)-> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.ENTRANCE).get(0)
	
	var playerCamera : Camera2D = player.get_node("Camera2D")
	playerCamera.limit_bottom = section.position.y + entraceAnchor.position.y
	playerCamera.limit_top = section.position.y

func GenerateLevels():
	var scene : PackedScene = load("res://Scenes/Levels/Level1/Level1-start.tscn")
	var instance: Node2D = scene.instantiate()
	
	var lastLevel = instance
	add_child(instance)
	sections.append(instance)
	
	for n in range(1, 30):
		if n % 5 == 0:
			scene = load("res://Scenes/Levels/SacrificialChamber.tscn")
		else:
			scene = load("res://Scenes/Levels/Level1/Level1-%d.tscn" % randi_range(1, 7))
		instance = scene.instantiate()
	
		var lastLevelAnchor : LevelAnchor = lastLevel.get_children().filter(func(x) -> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.EXIT).get(0)
		var currentLevelAnchor : Node2D = instance.get_children().filter(func(x)-> bool: return x is LevelAnchor and x.AnchorType == LevelAnchor.ELEVELANCHORTYPE.ENTRANCE).get(0)
		
		instance.position =Vector2(0, lastLevel.position.y + lastLevelAnchor.position.y - currentLevelAnchor.position.y)
		
		lastLevel = instance
		add_child(instance)
		sections.append(instance)

func nextSection():
	var section : Node2D = sections[currentSection]
	wall.position = section.position
	
	currentSection += 1
	SetPlayerCameraBehavior()
	var prevSection : LevelBase = sections[currentSection - 1]
	prevSection.call_deferred("queue_free")
