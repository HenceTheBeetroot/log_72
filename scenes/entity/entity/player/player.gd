extends Entity

@export var sprite_manager: SpriteManager
@export var state_chart: StateChart

var MAXSPEED: float = 400
var ACCELERATION: float = 3200

var speed: float = 0

# For sprites
var body_facing := Vector2.DOWN
var legs_facing := Vector2.DOWN

func update_body_facing(new: Vector2) -> void:
	body_facing = body_facing.move_toward(new, 0.25)

func update_legs_facing(new: Vector2) -> void:
	legs_facing = legs_facing.move_toward(new, 0.25)

func update_facing() -> bool:
	if !Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).is_zero_approx():
		facing = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
		return true
	return false

func _process(_delta) -> void:
	update_body_facing((get_global_mouse_position() - position).normalized())
	sprite_manager.find("body").angle = body_facing.angle_to(Vector2.DOWN)
	sprite_manager.find("legs").angle = legs_facing.angle_to(Vector2.DOWN)

func _physics_process(delta) -> void:
	velocity = velocity.move_toward(facing * speed, ACCELERATION * delta)
	move_and_slide()

# Process state machine
func _on_running_state_entered() -> void:
	data_entries.set_entry("ACTION", "RUNNING")

func _on_running_state_processing(_delta: float) -> void:
	if !update_facing():
		state_chart.send_event("no_movement_input")
	update_legs_facing(facing)
	speed = MAXSPEED

func _on_idle_state_entered() -> void:
	data_entries.set_entry("ACTION", "IDLE")

func _on_idle_state_processing(_delta: float) -> void:
	speed = 0
	if update_facing():
		state_chart.send_event("movement_input")

func _on_dash_state_entered() -> void:
	data_entries.set_entry("ACTION", "DASHING")
	update_facing()
	speed = 2 * MAXSPEED
	velocity = facing * speed

func _on_dash_state_exited() -> void:
	update_facing()

func _on_can_dash_state_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		state_chart.send_event("dash_input")

func _on_can_dash_state_entered() -> void:
	data_entries.set_entry("DASH", "READY")

func _on_cooldown_state_entered() -> void:
	data_entries.set_entry("DASH", "COOLDOWN")
