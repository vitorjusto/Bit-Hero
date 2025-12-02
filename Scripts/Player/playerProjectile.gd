class_name PlayerProjectile
extends CharacterBody2D

var SPEED = Vector2(80000, 0)
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
var timer = 0

func _ready() -> void:
	timer = upgradeManager.RangeProj * 10

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	
	if timer <= 0:
		queue_free()
		return
	
	velocity = SPEED * delta
	move_and_slide()

func onWallDeteced(body: Node2D) -> void:
	if upgradeManager.projPassTrhoughWall:
		return
	
	call_deferred("queue_free")


func onScreenExited() -> void:
	call_deferred("queue_free")
