class_name ParticleManager
extends Node2D

@onready var particle : PackedScene = load("res://Scenes/Particles/Particle.tscn")
var particles : Array[Particle] = []

func _ready() -> void:
	for i in range(0, 900):
		instantiateParticle()

func instantiateParticle() -> Particle:
	var instance = particle.instantiate()
	instance.setActive(false)
	add_child(instance)
	particles.append(instance)
	return instance

func AddParticles(position: Vector2, quantity : int):
	for i in range(0, quantity):
		activateParticles(position)

func activateParticles(position: Vector2):
	var inactive = particles.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = instantiateParticle()
	
	instance.position = position
	instance.setActive(true)
