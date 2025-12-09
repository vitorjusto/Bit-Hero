class_name Hud
extends CanvasLayer

@export var upgradeManager : UpgradeManager  
@export var player : Player  
@export var timeManager : TimeManager  

@onready var lblHp : Label = get_node("lblHp")
@onready var lblPower : Label = get_node("lblPower")
@onready var lblSpeed : Label = get_node("lblSpeed")
@onready var lblBullet : Label = get_node("lblBullet")
@onready var lblRange : Label = get_node("lblRange")
@onready var lblLife : Label = get_node("lblLife")
@onready var lblTime : Label = get_node("lblTime")

@onready var pnSpecial : Panel = get_node("pnSpecial")
@onready var pnDash : Panel = get_node("pnDash")
@onready var pnProjCooldown : Panel = get_node("pnProjCooldown")
@onready var pnHpBar : Panel = get_node("pnHpBar")
@onready var pnlife : Panel = get_node("pnlife")

@onready var pnSpecialBar1 : Panel = get_node("pnSpecialBar1")
@onready var pnSpecialBar2 : Panel = get_node("pnSpecialBar2")
@onready var pnSpecialBar3 : Panel = get_node("pnSpecialBar3")

@onready var ApLowHp : AnimationPlayer = get_node("ApLowHp")
@onready var ApLowTime : AnimationPlayer = get_node("ApLowTime")
@onready var ApLowLife : AnimationPlayer = get_node("ApLowLife")

func _ready() -> void:
	UpdateHud()

func UpdateHud():
	lblHp.text = "Hp: %d/%d" % [clamp(player.hp,0, 100), upgradeManager.MaxHP]
	lblPower.text = "Power: %d" % upgradeManager.Power
	lblSpeed.text = "Speed: %d" % upgradeManager.Speed
	lblRange.text = "Range: %d" % upgradeManager.RangeProj
	lblBullet.text = "Bullets: %d" % upgradeManager.bulletAmount
	
	pnDash.visible = upgradeManager.AllowDash
	pnSpecialBar3.visible = upgradeManager.Special > 2
	pnSpecialBar2.visible = upgradeManager.Special > 1
	pnSpecialBar1.visible = upgradeManager.Special > 0

func _process(delta : float) -> void:
	var time = timeManager.getTime()
	lblTime.text = "Time: %d" % time
	
	if time < 100:
		ApLowTime.play("lowTime")
	else:
		ApLowTime.stop()
		lblTime.visible = true

func updateSpecial(specialBar : int):
	pnSpecial.size = Vector2(specialBar, 32)
	
func updateDashCooldown(dashSpeed: float, dashInitialSpeed: float):
	var xSize = abs(((dashSpeed / dashInitialSpeed) * 300) - 300)
	pnDash.size = Vector2(xSize, 8)
	
func updateProjCooldown(currentcooldown: float, max: float):
	var xSize = abs(((currentcooldown / max) * 300) - 300)
	pnProjCooldown.size = Vector2(xSize, 8)

func UpdateHp(hpBar : float):
	lblHp.text = "Hp: %d/%d" % [clamp(player.hp,0, 100), upgradeManager.MaxHP]
	var xSize = abs(((hpBar / 20) * 72))
	pnHpBar.size = Vector2(xSize, 6)
	
	if player.hp < 4:
		ApLowHp.play("lowHp")
	else:
		ApLowHp.stop()
		lblHp.visible = true
	

func UpdateLife(life : float, lifebar: float, maxLifeBar : float):
	lblLife.text = "Life: %d" % life
	var xSize = (lifebar / maxLifeBar) * 100
	pnlife.size = Vector2(xSize, 6)
	
	if player.life == 1:
		ApLowLife.play("lowLife")
	else:
		ApLowLife.stop()
		lblLife.visible = true
	
