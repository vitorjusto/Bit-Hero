class_name TimeManager
extends Node2D

var time : float = 300
@onready var main: Main = get_tree().root.get_node("/root/Main")
func _process(delta: float) -> void:
	if main.blackScreenTimer > 0:
		time = 300
		return
	
	time -= delta

func getTime() -> int:
	return ceil(time)
