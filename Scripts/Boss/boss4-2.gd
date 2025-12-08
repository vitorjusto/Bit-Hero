extends CharacterBody2D

var SPEED = 200.0
var active = false
var isEntrering = true

@export var anchors : Array[Node2D]

@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var projManager: EnemiesProjectileManager = get_tree().root.get_node("/root/Main/EnemiesProjectileManager")
@onready var parent: Node2D = get_parent()

@onready var col: CollisionShape2D = get_node("CollisionShape2D")
@onready var hcol: CollisionShape2D = get_node("Hurtbox/CollisionShape2D2")
@onready var ani: AnimationPlayer = get_node("AnimationPlayer")
@onready var particleManager : ParticleManager = get_tree().root.get_node("/root/Main/ParticleManager")

var timer = 80

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	if isEntrering:
		EnteringStage(delta)
		return
	
	var xVel = clamp(velocity.x + (SPEED * delta), -300, 300)
	velocity = Vector2(xVel, 0)
	
	if position.x > 762.0:
		SPEED = abs(SPEED) * -1
	elif position.x < 562.0:
		SPEED = abs(SPEED)
	
	move_and_slide()
	
	timer -= delta * 60
	if timer <= 0:
		shootProjectiles()
		timer = 80

func EnteringStage(delta: float):
	position += Vector2(0, delta * 200)
	
	if position.y > 272.0:
		isEntrering = false

func onStart() -> void:
	active = true

func shootProjectiles():
	for a in anchors:
		ShootProjectile(a.position, 0)
		ShootProjectile(a.position, 0.1)
		ShootProjectile(a.position, 0.3)
		ShootProjectile(a.position, 0.5)
		ShootProjectile(a.position, -0.1)
		ShootProjectile(a.position, -0.3)
		ShootProjectile(a.position, -0.5)

func ShootProjectile(pos: Vector2, offset: float):
	
	var angle = atan2(pos.x + position.x + parent.position.x - player.position.x, pos.y+ position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(angle + offset) * -10, cos(angle + offset) * -10)
	projManager.ShootFireProjectile(pos + global_position, speed)


func onDefeat() -> void:
	active = false
	col.set_deferred("disabled", true)
	hcol.set_deferred("disabled", true)
	ani.play("new_animation")

func onAnimationFinished(anim_name: StringName) -> void:
	particleManager.AddParticles(position + get_parent().position, 5)
	call_deferred("queue_free")
