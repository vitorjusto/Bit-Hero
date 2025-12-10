class_name GameOverScreen
extends Node2D

@onready 
var score

func _ready():
	var lblScore : Label = get_node("lblScore")
	lblScore.text = str(score).pad_zeros(10)

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
