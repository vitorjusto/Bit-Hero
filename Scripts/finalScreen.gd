class_name FinalScreen
extends Node2D

var score
var timer = 100

func _ready():
	var lblScore : Label = get_node("lblScore")
	lblScore.text = str(score).pad_zeros(10)

func _process(delta: float) -> void:
	if timer >= 0:
		timer -= delta * 60
		return
	
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
