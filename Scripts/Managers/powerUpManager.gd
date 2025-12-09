class_name PowerUpManager
extends Node2D

func AddPowerUp(node: Node2D):
	call_deferred("add_child", node)

func ClearPowerUps():
	for i in get_children():
		i.call_deferred("queue_free")
