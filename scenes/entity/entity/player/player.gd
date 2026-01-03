extends Entity

@export var sprite_manager: SpriteManager
@export var state_chart: StateChart

var movement_target: Vector2

var MAXSPEED := 400
var ACCELERATION := 3200

# For sprites
var body_facing := Vector2.DOWN
var legs_facing := Vector2.DOWN

func _input(_event):
	if !Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).is_zero_approx():
		state_chart.send_event("movement_input")
	else:
		state_chart.send_event("no_movement_input")
		movement_target = Vector2.ZERO

func update_body_facing(new: Vector2):
	body_facing = body_facing.move_toward(new, 0.25)
	
func update_legs_facing(new: Vector2):
	legs_facing = legs_facing.move_toward(new, 0.25)

func _process(_delta):
	update_body_facing((get_global_mouse_position() - position).normalized())
	sprite_manager.find("body").angle = body_facing.angle_to(Vector2.DOWN)
	sprite_manager.find("legs").angle = legs_facing.angle_to(Vector2.DOWN)

func _physics_process(delta):
	velocity = velocity.move_toward(movement_target * MAXSPEED, ACCELERATION * delta)
	move_and_slide()

func _on_running_state_physics_processing(_delta):
	movement_target = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	update_legs_facing(movement_target)

func _on_running_state_entered():
	if Universal.show_entity_states:
		debug_text.text = "RUNNING"

func _on_idle_state_entered():
	if Universal.show_entity_states:
		debug_text.text = "IDLE"
