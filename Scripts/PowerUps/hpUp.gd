extends Area2D

@onready var hud : Hud = get_tree().root.get_node("/root/Main/Hud")
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")

func onPlayerDetected(body: Node2D) -> void:
	var player : Player = body
	player.Score += 100
	
	if upgradeManager.MaxHP == player.hp:
		player.addLifeBar()
		call_deferred("queue_free")
		return
	
	var hpbar = player.hpBar + 20
	
	if hpbar > 40:
		hpbar = 0
		player.set_deferred("hp", player.hp + 1)
		
	player.set_deferred("hpBar", hpbar)
	
	call_deferred("queue_free")
