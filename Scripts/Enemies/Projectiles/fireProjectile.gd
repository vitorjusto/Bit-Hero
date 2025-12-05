class_name FireProjectile
extends CharacterBody2D

var SPEED = Vector2(100, 100)

func _physics_process(delta: float) -> void:
	velocity += SPEED * delta*  60
	print(SPEED)
	if move_and_slide():
		queue_free()


func onScreenExited() -> void:
	call_deferred("queue_free")
