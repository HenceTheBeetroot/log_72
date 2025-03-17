extends Node2D
class_name SightHandler

@export var range: float
@onready var area_2d: Area2D
@onready var collision_shape: CollisionShape2D
@onready var shape: Shape2D

func _ready() -> void:
	# Create necessary nodes
	area_2d = Area2D.new()
	area_2d.name = "Area"
	collision_shape = CollisionShape2D.new()
	collision_shape.name = "Collision Shape"
	shape = CircleShape2D.new()
	
	# Configure shape and assign it
	shape.set_radius(range)
	collision_shape.set_shape(shape)
	
	# Add as children
	area_2d.add_child.call_deferred(collision_shape)
	self.add_child.call_deferred(area_2d)
	
	# Legacy raycast code because I know you're gonna need this in a bit
	#for i in CASTS:
	#	var ray: RayCast2D = RayCast2D.new()
	#	var angle: float = FOV * ((i - ((CASTS - 1.0) / 2.0)) / (CASTS - 1.0))
	#	ray.target_position = Vector2.UP.rotated(angle) * DISTANCE
	#	add_child(ray)
	#	ray.enabled = true

func find_rand_in_group(group: String) -> CharacterBody2D:
	var bodies = area_2d.get_overlapping_bodies()
	bodies.shuffle()
	for body in bodies:
		if body.is_in_group(group):
			return body
	return null
