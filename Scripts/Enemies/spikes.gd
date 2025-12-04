extends CharacterBody2D

enum EDIRECTION {UPDOWN, SIDEWAYS}

@export var direction : EDIRECTION
@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()

var speed = Vector2(0, 0)
const FIXEDSPEED = 30000

func _physics_process(delta: float) -> void:
	if speed == Vector2.ZERO:
		VerifyPlayer()
	else:
		velocity = speed * delta
		if move_and_slide():
			speed = Vector2(0, 0)

func VerifyPlayer():
	if direction == EDIRECTION.UPDOWN:
		if abs(player.position.x -(position.x + parent.position.x)) < 100:
			speed = Vector2(0, FIXEDSPEED if player.position.y > (position.y + parent.position.y) else -FIXEDSPEED)
	elif direction == EDIRECTION.SIDEWAYS:
		if abs(player.position.y - (position.y + parent.position.y)) < 100:
			speed = Vector2(FIXEDSPEED if player.position.x > (position.x + parent.position.x) else -FIXEDSPEED, 0)
