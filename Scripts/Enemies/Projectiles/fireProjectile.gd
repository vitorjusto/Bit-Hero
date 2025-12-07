class_name FireProjectile
extends CharacterBody2D

var SPEED = Vector2(100, 100)
var active = false
@onready var col : CollisionShape2D = get_node("CollisionShape2D")

func _ready() -> void:
	setActive(false)

func _physics_process(delta: float) -> void:
	velocity += SPEED * delta*  60
	if move_and_slide():
		setActive(false)


func onScreenExited() -> void:
	setActive(false)

func setActive(value: bool):
	set_physics_process(value)
	active = value
	process_mode = Node.PROCESS_MODE_ALWAYS if value else Node.PROCESS_MODE_DISABLED

	col.set_deferred("disabled", not value)
	visible = value

	if active:
		rotation = SPEED.angle()
	else:
		velocity = Vector2.ZERO
