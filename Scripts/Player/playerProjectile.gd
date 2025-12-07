class_name PlayerProjectile
extends CharacterBody2D

var SPEED = Vector2(80000, 0)
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var sprite : Node2D = get_node("PlayerProjectile")
@onready var col : CollisionShape2D = get_node("CollisionShape2D")

var active = false
var timer = 0
var powerModifier = 1

func _ready() -> void:
	setActive(false)

func _physics_process(delta: float) -> void:
	timer -= delta * 60
	
	if timer <= 0:
		setActive(false)
		return
	
	velocity = SPEED * delta
	move_and_slide()

func onWallDeteced(body: Node2D) -> void:
	if upgradeManager.projPassTrhoughWall:
		return
	
	setActive(false)


func onScreenExited() -> void:
	setActive(false)

func setActive(value: bool):
	set_physics_process(value)
	sprite.visible = value
	process_mode = Node.PROCESS_MODE_INHERIT if value else Node.PROCESS_MODE_DISABLED
	col.set_deferred("disabled", not value)
	active = value
	
	if active:
		timer = upgradeManager.RangeProj * 10
		rotation = SPEED.angle()
