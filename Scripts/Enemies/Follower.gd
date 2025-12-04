extends CharacterBody2D

@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()

func _physics_process(delta: float) -> void:
	var angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	velocity += Vector2(sin(angle) * -1000, cos(angle) * -1000) * delta
	
	move_and_slide()
