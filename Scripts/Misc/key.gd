extends Area2D

func onPlayerDetected(body: Node2D) -> void:
	call_deferred("queue_free")
