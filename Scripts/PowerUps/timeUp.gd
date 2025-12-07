extends Area2D

@onready var timeManager : TimeManager = get_tree().root.get_node("/root/Main/TimeManager")

func onPlayerDetected(body: Node2D) -> void:
	timeManager.time += clamp(10, 0, 999)
	call_deferred("queue_free")
