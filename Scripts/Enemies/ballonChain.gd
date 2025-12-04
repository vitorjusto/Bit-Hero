extends StaticBody2D

@export var startAngule = 0
@export var speed = 100
@export var changeSpacing = false

@onready var ball : Node2D = get_node("Node2D")
@onready var ani : AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	if changeSpacing:
		ani.play("new_animation")

func _process(delta: float) -> void:
	ball.rotation = deg_to_rad(startAngule)
	startAngule += speed * delta
