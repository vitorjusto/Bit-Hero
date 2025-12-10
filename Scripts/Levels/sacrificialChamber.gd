class_name SacrificialChamber
extends LevelBase

@export var downgrade1: Node2D
@export var downgrade2: Node2D
@export var downgrade3: Node2D
@export var downgrade4: Node2D
@export var door: Node2D
@export var label: Label

func OnPlayerGet() -> void:
	get_node("StaticBody2D").call_deferred("queue_free")
	downgrade1.call_deferred("queue_free")
	downgrade2.call_deferred("queue_free")
	downgrade3.call_deferred("queue_free")
	downgrade4.call_deferred("queue_free")
	door.call_deferred("queue_free")
	label.call_deferred("queue_free")
