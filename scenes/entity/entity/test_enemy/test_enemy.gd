extends Entity

@export var tracker: EntityTrackerManager
@export var state_chart: StateChart

var MAXSPEED := 300
var ACCELERATION := 600

var movement_dir: Vector2

func _process(_delta: float) -> void:
	movement_dir = tracker.get_closest_target().normalized()
	#if sight_handler.get_bodies_in_group("player_main"):
		#for body in sight_handler.get_bodies_in_group("player_main"):
			#poi_handler.update_poi("player", body.position, true)
		#state_chart.send_event("target_added")
	#var player_poi = poi_handler.get_poi("player")
	#if player_poi:
		#movement_dir = (player_poi.position - position).normalized()
		#if player_poi.position.distance_to(position) < 5:
			#poi_handler.remove_poi(player_poi)
			#state_chart.send_event("all_targets_lost")

# Simple movement
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(movement_dir * MAXSPEED, ACCELERATION * delta)
	move_and_slide()

func _on_target_in_area_state_entered() -> void:
	if Universal.show_entity_states:
		debug_text.text = "TRACKING_IN_AREA"

func _on_idle_state_entered() -> void:
	movement_dir = Vector2.ZERO
	if Universal.show_entity_states:
		debug_text.text = "IDLE"
