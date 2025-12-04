extends CharacterBody2D

enum ESHOOTTYPE {UNI, TRI, PENTA, SPREAD, SPREADER}
@export var ShootType : ESHOOTTYPE

@onready var player: Player = get_tree().root.get_node("/root/Main/Player")
@onready var parent: Node2D = get_parent()

@onready var Shoottimer = MAXSHOOTTIMER
const MAXSHOOTTIMER = 30
var shootCicle = 0

@onready var proj : PackedScene = load("res://Scenes/Enemies/Projectiles/RegularEnemyProjectile.tscn")
@onready var main: Main = get_tree().root.get_node("/root/Main")

var angle = 0
var timer = 80
var isfollowing = true

func _ready():
	ChangeAngle()

func _physics_process(delta: float) -> void:
	
	if isfollowing:
		FollowPlayer(delta)
	else:
		Shoot(delta)

func FollowPlayer(delta: float):
	timer -= delta * 60
	if timer <= 0:
		ChangeAngle()
		isfollowing = false
		timer = 100
		return
	
	velocity = Vector2(sin(angle) * -20000, cos(angle) * -20000) * delta
	if move_and_slide():
		ChangeAngle()
		isfollowing = false
		timer = 100
	

func Shoot(delta: float ):
	Shoottimer -= delta * 60
	
	if Shoottimer > 0:
		return
		
	Shoottimer += MAXSHOOTTIMER
	
	if ShootType == ESHOOTTYPE.UNI:
		ShootProj(0)
	if ShootType == ESHOOTTYPE.TRI:
		ShootProj(0)
		ShootProj(0.3)
		ShootProj(-0.3)
	if ShootType == ESHOOTTYPE.PENTA:
		ShootProj(0)
		ShootProj(0.25)
		ShootProj(-0.25)
		ShootProj(0.5)
		ShootProj(-0.5)
	if ShootType == ESHOOTTYPE.SPREAD:
		ShootLinearProjectile(0)
		ShootLinearProjectile(45)
		ShootLinearProjectile(90)
		ShootLinearProjectile(135)
		ShootLinearProjectile(180)
		ShootLinearProjectile(225)
		ShootLinearProjectile(270)
		ShootLinearProjectile(315)
	if ShootType == ESHOOTTYPE.SPREADER:
		ShootLinearProjectile(0)
		ShootLinearProjectile(15)
		ShootLinearProjectile(30)
		ShootLinearProjectile(45)
		ShootLinearProjectile(60)
		ShootLinearProjectile(75)
		ShootLinearProjectile(90)
		ShootLinearProjectile(105)
		ShootLinearProjectile(120)
		ShootLinearProjectile(135)
		ShootLinearProjectile(150)
		ShootLinearProjectile(165)
		ShootLinearProjectile(180)
		ShootLinearProjectile(195)
		ShootLinearProjectile(210)
		ShootLinearProjectile(225)
		ShootLinearProjectile(240)
		ShootLinearProjectile(255)
		ShootLinearProjectile(270)
		ShootLinearProjectile(285)
		ShootLinearProjectile(300)
		ShootLinearProjectile(315)
		ShootLinearProjectile(330)
		ShootLinearProjectile(345)
	
	shootCicle += 1
	if shootCicle > 5:
		isfollowing = true
		shootCicle = 0

func ShootProj(offSet: float):
	var projAngle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
	var speed = Vector2(sin(projAngle + offSet) * -10, cos(projAngle + offSet) * -10)
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.add_child(instance)



func ShootLinearProjectile(angle: float):
	var speed = Vector2(sin(deg_to_rad(angle)) * -10, cos(deg_to_rad(angle)) * -10)
	
	var instance : RegularEnemyProjectile = proj.instantiate()
	instance.SPEED = speed
	instance.position = global_position
	main.add_child(instance)
	
func ChangeAngle():
	angle = atan2(position.x + parent.position.x - player.position.x, position.y + parent.position.y - player.position.y)
