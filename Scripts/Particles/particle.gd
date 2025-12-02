extends Node2D

var rad: int
var speed: int

func _ready() -> void:
	rad = deg_to_rad(randf_range(0, 359))
	position += Vector2(sin(rad), cos(rad)) * 20
	speed = randi_range(130, 200)

func _process(delta: float) -> void:
	position += Vector2(sin(rad), cos(rad)) * delta * speed
	speed -= 50 * delta
