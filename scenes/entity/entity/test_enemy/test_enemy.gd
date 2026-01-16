extends Entity

@export var tracker: EntityTrackerManager
@export var state_chart: StateChart

var MAXSPEED: float = 300
var ACCELERATION: float = 600

var speed: float = 0

# Simple movement
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(facing * speed, ACCELERATION * delta)
	move_and_slide()

# Accept signals
func _on_entity_tracker_manager_target_added(_name: Variant) -> void:
	state_chart.send_event("target_added")

func _on_entity_tracker_manager_target_removed(_name: Variant) -> void:
	state_chart.send_event("all_targets_removed")

# Process state machine
func _on_target_in_area_state_entered() -> void:
	data_entries.set_entry("STATE", "TRACKING_IN_AREA")

func _on_targeting_state_processing(_delta: float) -> void:
	facing = tracker.get_closest_target().normalized()
	speed = MAXSPEED

func _on_idle_state_entered() -> void:
	data_entries.set_entry("STATE", "IDLE")

func _on_idle_state_processing(_delta: float) -> void:
	speed = 0
