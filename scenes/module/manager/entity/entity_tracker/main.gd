extends Node2D
class_name EntityTrackerManager

signal target_added(name)
signal target_removed(name)
signal all_targets_removed

@export var area_interface: AreaInterface
@export var poi_interface: POIInterface
@export var entity: Entity

var tracked_bodies: Dictionary[PhysicsBody2D, SightLine] = {}

func _ready() -> void:
	await area_interface.ready
	await poi_interface.ready
	area_interface.area.body_entered.connect(body_entered)

func _process(_delta: float) -> void:
	for body: PhysicsBody2D in tracked_bodies.keys():
		if tracked_bodies[body].is_colliding(): continue
		update_body(body)
	
	# Clear reached POIs
	for poi in poi_interface.get_all_pois():
		if (poi.global_position - global_position).length() < 10:
			update_body(poi.custom_data["body"])
			target_removed.emit(poi.name)
			poi.queue_free()
			if poi_interface.get_all_pois().size() == 1:
				all_targets_removed.emit()

func clear_blocked_rays() -> void:
	for body: PhysicsBody2D in tracked_bodies.keys():
		if body not in area_interface.area.get_overlapping_bodies() and tracked_bodies[body].is_colliding():
			tracked_bodies[body].queue_free()
			tracked_bodies.erase(body)

func update_body(body: PhysicsBody2D):
	# if line of sight exists to a body
	if !tracked_bodies[body].is_colliding():
		# emit signal if target is being added
		if poi_interface.get_poi(body.name) == null:
			target_added.emit(body.name)
			# add poi
			poi_interface.update_poi(body.name, body.position, true)
			poi_interface.set_custom_data(body.name, "body", body)
			poi_interface.get_poi(body.name).add_nested_poi(body.name + "_prediction")
		else:
			# update poi position
			poi_interface.update_poi(body.name, body.position)

func body_entered(body: PhysicsBody2D) -> void:
	# Disallow self as a POI
	if body == get_parent(): return
	if !tracked_bodies.has(body):
		tracked_bodies[body] = SightLine.new()
		tracked_bodies[body].target = body
		add_child(tracked_bodies[body])
		tracked_bodies[body].update_target()
		tracked_bodies[body].force_raycast_update()

func get_closest_target() -> Vector2:
	if !poi_interface.get_all_pois(): return Vector2.ZERO
	var target: Vector2 = poi_interface.get_all_pois()[0].global_position - global_position
	for poi in poi_interface.get_all_pois():
		if (poi.global_position - global_position).length() < target.length():
			target = poi.global_position - global_position
	return target
