extends Area2D

@onready var manager : SpecialManager = get_tree().root.get_node("/root/Main/SpecialManager")
@onready var player : Player = get_tree().root.get_node("/root/Main/Player")

func onPlayerDeteced(body: Node2D) -> void:
	manager.addSpecial(20)
	player.Score += 100
	call_deferred("queue_free")
