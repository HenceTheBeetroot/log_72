extends CharacterBody2D
class_name Entity

var debug_text: Label

func _ready() -> void:
	# the editor isn't working for some reason so i gotta do this here like a PLEBIAN
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	
	set_motion_mode(MOTION_MODE_FLOATING) # set top-down physics
	if Universal.show_entity_states: # displays current entity state in debug mode
		debug_text = Label.new()
		debug_text.text = "UNDEFINED"
		call_deferred("add_child", debug_text)
