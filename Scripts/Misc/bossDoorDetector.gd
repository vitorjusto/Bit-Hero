extends Area2D

@export var door : StaticBody2D


func OnPlayerDetected(body: Node2D) -> void:
	door.position = Vector2.ZERO
