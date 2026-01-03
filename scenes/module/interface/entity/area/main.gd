extends Node2D
class_name AreaInterface

@export var radius: float = 100

@onready var area := $Area2D
@onready var collision := $Area2D/CollisionShape2D

func _ready() -> void:
	collision.shape.set_radius(radius)
