extends CharacterBody2D
class_name Entity

# funny wrapper class :D

func _ready() -> void:
	set_motion_mode(1)
	add_to_group("entity")
	
