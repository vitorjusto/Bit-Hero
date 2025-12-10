extends Area2D


func onPlayerDetected(body: Node2D) -> void:
	var player : Player = body
	player.Score += 100
	
	if player.life == 9:
		call_deferred("queue_free")
		return
	
	player.set_deferred("life", player.life + 1)
	call_deferred("queue_free")
