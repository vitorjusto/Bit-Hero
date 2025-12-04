extends Node2D

@export var enemies : Array[Node2D]
var amount = 0

func _ready() -> void:
	amount = enemies.size()
	for enemy : Node2D in  enemies:
		enemy.connect("tree_exited", onEnemyDefeat)

func onEnemyDefeat():
	amount -= 1
	if amount == 0:
		call_deferred("queue_free")
