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
		if timeManager.getTime() <= 0:
			timeManager.emit_signal("onTimeUp")
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
	setDescription()

func setDescription():
	var label: Label = get_node("lblDescription")
	
	if downgradeType == EDowngradeType.MAXHP:
		label.text = "-1 Max Hp"
	if downgradeType == EDowngradeType.POWER:
		label.text = "-1 Power"
	if downgradeType == EDowngradeType.SPECIAL:
		label.text = "-1 Max Special"
	if downgradeType == EDowngradeType.RECHARGINGSPECIAL:
		label.text = "No Special Recharging"
	if downgradeType == EDowngradeType.BULLET:
		label.text = "-1 Bullet"
	if downgradeType == EDowngradeType.SPEED:
		label.text = "-1 Speed"
	if downgradeType == EDowngradeType.RANGE:
		label.text = "-1 Range"
	if downgradeType == EDowngradeType.COOLDOWN:
		label.text = "Shoot Cooldown Up"
	if downgradeType == EDowngradeType.ENEMIESDROPSHP:
		label.text = "Enemies Don't Drop Hp"
	if downgradeType == EDowngradeType.ENEMIESDROPSSPECIALS:
		label.text = "Enemies Don't Drop Special"
	if downgradeType == EDowngradeType.ENEMIESDROPSLIFE:
		label.text = "Enemies Don't Drop Life"
	if downgradeType == EDowngradeType.LIFEGENERATE:
		label.text = "No Life Regeneration"
	if downgradeType == EDowngradeType.PROJECTILEPIERCING:
		label.text = "No Projectile Piercing"
	if downgradeType == EDowngradeType.PROJECTILEPASSTRHOUGWALL:
		label.text = "Projectiles don't go through walls"
	if downgradeType == EDowngradeType.DASH:
		label.text = "No Dash"
	if downgradeType == EDowngradeType.DIAGONALMOVIMENT:
		label.text = "No Diagonal Moviment"
	if downgradeType == EDowngradeType.HP:
		label.text = "-1 Hp"
	if downgradeType == EDowngradeType.LIFE:
		label.text = "-1 Life"
	if downgradeType == EDowngradeType.HPGENERATE:
		label.text = "No Hp Regeneration"
	if downgradeType == EDowngradeType.TIME:
		label.text = "-100 Time"
	if downgradeType == EDowngradeType.AUTOSHOOT:
		label.text = "No Autoshoot"
