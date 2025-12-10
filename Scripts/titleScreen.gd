extends Node2D

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
