class_name TimedRegularEnemyProjectile
extends CharacterBody2D

var SPEED = Vector2(100, 100)
var time = 0

func _physics_process(delta: float) -> void:
	time -= delta * 60
	
	if time <= 0:
		queue_free()
	
	velocity = SPEED * 60
	print(SPEED)
	if move_and_slide():
		queue_free()

func onScreenExited() -> void:
	call_deferred("queue_free")
