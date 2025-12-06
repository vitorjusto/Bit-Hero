class_name RegularEnemyProjectile
extends CharacterBody2D

var SPEED = Vector2(100, 100)

func _ready() -> void:
	rotate(SPEED.angle())

func _physics_process(delta: float) -> void:
	velocity = SPEED * 60
	if move_and_slide():
		queue_free()


func onScreenExited() -> void:
	call_deferred("queue_free")
