extends CharacterBody2D
class_name Entity

var debug_text: Label
var data_entries = DataEntries.new()
var facing = Vector2.DOWN

func _ready() -> void:
	# the editor isn't working for some reason so I gotta do this here like a PLEBIAN
	set_collision_layer_value(1, true) # You are an entity
	set_collision_mask_value(1, false) # Do not scan entities
	set_collision_layer_value(2, false) # You are not a wall
	set_collision_mask_value(2, true) # Scan walls
	
	set_motion_mode(MOTION_MODE_FLOATING) # set top-down physics
	add_child(data_entries) # stores data labels
	
	if Universal.entity_collision_circles:
		var render_circle = Node2D.new()
		render_circle.set_script(load("res://scenes/debug/render_entity_collision_circle.gd"))
		add_child(render_circle)
