class_name DowngradeBase
extends Area2D

enum EDowngradeType {
	NONE, 
	MAXHP, 
	POWER, 
	SPECIAL,
	RECHARGINGSPECIAL, 
	BULLET, 
	SPEED, 
	RANGE,
	COOLDOWN,
	ENEMIESDROPSHP,
	ENEMIESDROPSSPECIALS,
	ENEMIESDROPSLIFE,
	LIFEGENERATE,
	PROJECTILEPIERCING,
	PROJECTILEPASSTRHOUGWALL,
	DASH,
	DIAGONALMOVIMENT,
	HP,
	LIFE,
	HPGENERATE,
	TIME,
	AUTOSHOOT
	}
@export var downgradeType : EDowngradeType

signal onPlayerGet()
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var hud : Hud = get_tree().root.get_node("/root/Main/Hud")
@onready var player : Player = get_tree().root.get_node("/root/Main/Player")
@onready var timeManager : TimeManager = get_tree().root.get_node("/root/Main/TimeManager")

func onPlayerDetected(body: Node2D) -> void:
	ProcessDowngrade()
	emit_signal("onPlayerGet")
	call_deferred("queue_free")

func ProcessDowngrade():
	if downgradeType == EDowngradeType.MAXHP:
		upgradeManager.MaxHP -= 1
		player.hp = clamp(player.hp, 0, upgradeManager.MaxHP)
	if downgradeType == EDowngradeType.POWER:
		upgradeManager.Power -= 1
	if downgradeType == EDowngradeType.SPECIAL:
		upgradeManager.Special -= 1
	if downgradeType == EDowngradeType.RECHARGINGSPECIAL:
		upgradeManager.passiveRechargingSpecial = false
	if downgradeType == EDowngradeType.BULLET:
		upgradeManager.bulletAmount -= 1
	if downgradeType == EDowngradeType.SPEED:
		upgradeManager.Speed -= 1
	if downgradeType == EDowngradeType.RANGE:
		upgradeManager.RangeProj -= 1
	if downgradeType == EDowngradeType.COOLDOWN:
		upgradeManager.ProjCoolDown += 5
	if downgradeType == EDowngradeType.ENEMIESDROPSHP:
		upgradeManager.EnemiesDropsHP = false
	if downgradeType == EDowngradeType.ENEMIESDROPSSPECIALS:
		upgradeManager.EnemiesDropsSpecial = false
	if downgradeType == EDowngradeType.ENEMIESDROPSLIFE:
		upgradeManager.EnemiesDropsLife = false
	if downgradeType == EDowngradeType.LIFEGENERATE:
		upgradeManager.LifeRegenerate = false
	if downgradeType == EDowngradeType.PROJECTILEPIERCING:
		upgradeManager.projPiercing = false
	if downgradeType == EDowngradeType.PROJECTILEPASSTRHOUGWALL:
		upgradeManager.projPassTrhoughWall = false
	if downgradeType == EDowngradeType.DASH:
		upgradeManager.AllowDash = false
	if downgradeType == EDowngradeType.DIAGONALMOVIMENT:
		upgradeManager.Move8Directions = false
	if downgradeType == EDowngradeType.HP:
		player.hp -= 1
	if downgradeType == EDowngradeType.LIFE:
		player.life -= 1
	if downgradeType == EDowngradeType.HPGENERATE:
		upgradeManager.HpRegenerate = false
	if downgradeType == EDowngradeType.TIME:
		timeManager.time -= 100
	if downgradeType == EDowngradeType.AUTOSHOOT:
		upgradeManager.AutoShoot = false
	
	hud.UpdateHud()


func onScreenEntrered() -> void:
	var availableDowngrade = []
	
	if upgradeManager.MaxHP > 1:
		availableDowngrade.append(EDowngradeType.MAXHP)
	if upgradeManager.Power > 1:
		availableDowngrade.append(EDowngradeType.POWER)
	if upgradeManager.Special > 1:
		availableDowngrade.append(EDowngradeType.SPECIAL)
	if upgradeManager.passiveRechargingSpecial:
		availableDowngrade.append(EDowngradeType.RECHARGINGSPECIAL)
	if upgradeManager.bulletAmount > 1:
		availableDowngrade.append(EDowngradeType.BULLET)
	if upgradeManager.Speed > 1:
		availableDowngrade.append(EDowngradeType.SPEED)
	if upgradeManager.RangeProj > 1:
		availableDowngrade.append(EDowngradeType.RANGE)
	if upgradeManager.ProjCoolDown < 30:
		availableDowngrade.append(EDowngradeType.COOLDOWN)
	if upgradeManager.EnemiesDropsHP:
		availableDowngrade.append(EDowngradeType.ENEMIESDROPSHP)
	if upgradeManager.EnemiesDropsSpecial:
		availableDowngrade.append(EDowngradeType.ENEMIESDROPSSPECIALS)
	if upgradeManager.EnemiesDropsLife:
		availableDowngrade.append(EDowngradeType.ENEMIESDROPSLIFE)
	if upgradeManager.projPiercing:
		availableDowngrade.append(EDowngradeType.PROJECTILEPIERCING)
	if upgradeManager.projPassTrhoughWall:
		availableDowngrade.append(EDowngradeType.PROJECTILEPASSTRHOUGWALL)
	if upgradeManager.AllowDash:
		availableDowngrade.append(EDowngradeType.DASH)
	if upgradeManager.Move8Directions:
		availableDowngrade.append(EDowngradeType.DIAGONALMOVIMENT)
	if player.hp > 1:
		availableDowngrade.append(EDowngradeType.HP)
	if player.life > 1:
		availableDowngrade.append(EDowngradeType.LIFE)
	if upgradeManager.HpRegenerate:
		availableDowngrade.append(EDowngradeType.HPGENERATE)
	if upgradeManager.AutoShoot:
		availableDowngrade.append(EDowngradeType.AUTOSHOOT)
	
	availableDowngrade.append(EDowngradeType.TIME)
	
	downgradeType = availableDowngrade[randi_range(0, availableDowngrade.size() -1)]
	print(downgradeType)
