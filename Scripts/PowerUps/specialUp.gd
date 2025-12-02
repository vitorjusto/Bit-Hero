extends Area2D

@onready var manager : SpecialManager = get_tree().root.get_node("/root/Main/SpecialManager")

func onPlayerDeteced(body: Node2D) -> void:
	manager.addSpecial(20)
	call_deferred("queue_free")
