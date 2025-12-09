class_name Player
extends CharacterBody2D

var hp = 2
var hpBar : float = 0
const SPEED = 130.0
const JUMP_VELOCITY = -400.0
@onready var upgradeManager : UpgradeManager = get_tree().root.get_node("/root/Main/UpgradeManager")
@onready var hud : Hud = get_tree().root.get_node("/root/Main/Hud")
@onready var particleManager : ParticleManager = get_tree().root.get_node("/root/Main/ParticleManager")
@onready var col: CollisionShape2D = get_node("CollisionShape2D")
@onready var aniSprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var life = 3
var lifeBar = 0
var maxLifeBar = 20

var dashSpeed: float = 0
var dashInitialSpeed: float = 1000
var allowMove = true
var playerDestroyedTimer = 0

signal playerDied
func _physics_process(delta: float) -> void:
	
	if playerDestroyedTimer > 0:
		playerDestroyedTimer -= delta * 60
		
		if playerDestroyedTimer <= 0:
			emit_signal("playerDied")
		return
	
	var currentSpeed = (SPEED * upgradeManager.Speed) + getSpeed(delta)
	if upgradeManager.Move8Directions:
		velocity = Input.get_vector("Left", "Right", "Up", "Down") * currentSpeed 
	else:
		var currentInput = Input.get_vector("Left", "Right", "Up", "Down")
		if currentInput.x != 0:
			currentInput.y = 0
			currentInput.x = 1 if currentInput.x > 0 else -1
		
		velocity = currentInput * currentSpeed 
	
	if allowMove:
		move_and_slide()
	
	HandleDamageAnimation(delta)
	
	if upgradeManager.MaxHP > hp and upgradeManager.HpRegenerate:
		hpBar += delta * 0.5
		if hpBar > 40:
			hpBar -= 40
			hp += 1
	
	hud.UpdateHp(hpBar)
	hud.UpdateLife(life, lifeBar, maxLifeBar)

func addLifeBar():
	if life == 9:
		return
	
	if not upgradeManager.LifeRegenerate:
		return
	
	var currentLifeBar = lifeBar + 1
	set_deferred("lifeBar", currentLifeBar)

	if currentLifeBar < maxLifeBar:
		return
	
	set_deferred("lifeBar", 0)
	set_deferred("maxLifeBar", maxLifeBar + round(maxLifeBar / 2))
	set_deferred("life", life + 1)

func getSpeed(delta: float) -> float:
	
	if not upgradeManager.AllowDash:
		return 0
	
	if(Input.get_vector("Left", "Right", "Up", "Down") != Vector2.ZERO and Input.is_action_just_pressed("Dash") and dashSpeed <= 0):
		dashSpeed = dashInitialSpeed
	elif dashSpeed > 0:
		dashSpeed -= 2500 * delta
		if dashSpeed < 0:
			dashSpeed = 0
	
	hud.updateDashCooldown(dashSpeed, dashInitialSpeed)
	return dashSpeed

##Damage vars
var iframes = 0
var aniIFrames = 0
var insideEnemys = []

func HandleDamageAnimation(delta):
	if iframes == 0:
		if insideEnemys.is_empty():
			return
		takeDamage()
	
	iframes -= delta * 60
	if iframes <= 0:
		visible = true
		iframes = 0
		aniIFrames = 0
		return
	
	aniIFrames -= delta * 60
	if aniIFrames <= 0:
		visible = not visible
		aniIFrames = 10

func takeDamage():
	if iframes > 0:
		return
	
	hp -= 1
	
	if hp == 0:
		handlePlayerDeath()
	else:
		emit_signal("onDamage")
		velocity.y += -500
		iframes = 100
		

func handlePlayerDeath():
	playerDestroyedTimer = 100
	particleManager.AddParticles(position, 10)
	allowMove = false
	visible = false
	col.set_deferred("disabled", true)
	aniSprite.visible = false

func OnEnemyDeteced(body: Node2D) -> void:
	insideEnemys.append(body)
	takeDamage()

func onEnemyExited(body: Node2D) -> void:
	insideEnemys.erase(body)

signal onDamage
