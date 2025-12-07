class_name Particle
extends Node2D

var rad: float
var speed: float
var active = false
@onready var ani : AnimationPlayer = get_node("AnimationPlayer")

func _process(delta: float) -> void:
	position += Vector2(sin(rad), cos(rad)) * delta * speed
	speed -= 50 * delta

func setActive(value : bool):
	active = value
	visible = value
	process_mode = Node.PROCESS_MODE_INHERIT if value else Node.PROCESS_MODE_DISABLED
	
	if value:
		rad = deg_to_rad(randf_range(0, 359))
		position += Vector2(sin(rad), cos(rad)) * 20
		speed = randi_range(130, 200)
		ani.play("new_animation")
	

func onAnimationFinished(anim_name: StringName) -> void:
	setActive(false)
