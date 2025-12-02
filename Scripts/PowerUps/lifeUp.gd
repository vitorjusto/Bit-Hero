extends Area2D


func onPlayerDetected(body: Node2D) -> void:
	var player : Player = body
	
	if player.life == 9:
		call_deferred("queue_free")
		return
	
	player.set_deferred("life", player.life + 1)
	call_deferred("queue_free")
