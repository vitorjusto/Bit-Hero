class_name LevelAnchor
extends Node2D

enum ELEVELANCHORTYPE { ENTRANCE, EXIT }

@export var AnchorType : ELEVELANCHORTYPE
@onready var main : Main = get_tree().root.get_node("/root/Main")

func _on_area_entrance_body_entered(body: Node2D) -> void:
	if AnchorType == ELEVELANCHORTYPE.EXIT:
		main.nextSection()
