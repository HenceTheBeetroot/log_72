extends CharacterBody2D
class_name Entity

# funny wrapper class :D

func _ready() -> void:
	set_motion_mode(MOTION_MODE_FLOATING) # set top-down physics
	add_to_group("entity")
