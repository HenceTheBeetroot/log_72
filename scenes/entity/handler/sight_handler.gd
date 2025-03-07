extends Node2D
class_name SightHandler

@export var FOV: float = 90
@export var DISTANCE: float = 300
@onready var area_2d = $Area2D
@onready var circle = $Area2D/CollisionShape2D

func _ready() -> void:
	FOV = deg_to_rad(FOV)
	generate_field()

func generate_field() -> void:
	circle.scale = DISTANCE
	#for i in CASTS:
	#	var ray: RayCast2D = RayCast2D.new()
	#	var angle: float = FOV * ((i - ((CASTS - 1.0) / 2.0)) / (CASTS - 1.0))
	#	ray.target_position = Vector2.UP.rotated(angle) * DISTANCE
	#	add_child(ray)
	#	ray.enabled = true

func _process(delta: float) -> void:
	pass
