extends Area2D



func _on_body_entered(body: Node2D) -> void:
		var player : Player = body
		var newScene : FinalScreen = preload("res://Scenes/FinalScreen.tscn").instantiate()
		newScene.score = player.Score
		
		get_tree().root.add_child(newScene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = newScene
