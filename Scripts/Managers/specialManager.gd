class_name SpecialManager
extends Node2D

@export var upgradeManager : UpgradeManager
@export var hud : Hud
@export var main : Main
@export var player : Player
@onready var special1 : PackedScene = load("res://Scenes/Specials/SpecialProjectile1.tscn")

var specialBar = 0

func _process(delta: float) -> void:
	if main.blackScreenTimer > 0:
		return
	if upgradeManager.passiveRechargingSpecial:
		specialBar += 6 * delta
	
	specialBar = clamp(specialBar, 0, upgradeManager.Special * 100)
	hud.updateSpecial(specialBar)
	
	if Input.is_action_just_pressed("Special"):
		HandleSpecial()

func addSpecial(amount : int):
	if specialBar >= upgradeManager.Special * 100:
		player.addLifeBar()
	else:
		specialBar = clamp(specialBar + amount, 0, upgradeManager.Special * 100)

func HandleSpecial():
	if specialBar >= 100:
		specialBar -= 100
		
		var instance : SpecialBase = special1.instantiate()
		
		var mouse_pos = get_viewport().get_mouse_position()
		#Get relative position from player according to viewport
		var playerGlobalPosition = player.get_global_transform_with_canvas().origin
	
		var angle = atan2(playerGlobalPosition.x - mouse_pos.x, playerGlobalPosition.y - mouse_pos.y)
		instance.speed = Vector2(sin(angle) * -20000, cos(angle) * -20000)
		
		instance.position = player.position + Vector2(sin(angle) * -50, cos(angle) * -50)
		main.add_child(instance)
	
