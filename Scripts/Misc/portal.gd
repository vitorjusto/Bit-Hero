extends Area2D

@onready var main: Main = get_tree().root.get_node("/root/Main")

func onPlayerDeteced(body: Node2D) -> void:
	main.nextLevel()
