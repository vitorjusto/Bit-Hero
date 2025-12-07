class_name TimeManager
extends Node2D

var time : float = 300

func _process(delta: float) -> void:
	time -= delta

func getTime() -> int:
	return ceil(time)
