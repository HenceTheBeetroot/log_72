extends Node2D
class_name EntityTrackerManager

@export var area_interface: AreaInterface
@export var poi_interface: POIInterface

var tracked_bodies: Dictionary[PhysicsBody2D, SightLine] = {}

func _ready() -> void:
	await area_interface.ready
	await poi_interface.ready
	area_interface.area.body_entered.connect(body_entered)

func _process(_delta: float) -> void:
	for body in tracked_bodies.keys():
		# if line of sight exists to a body
		if !tracked_bodies[body].is_colliding():
			# add/update poi
			poi_interface.update_poi(body.name, body.position, true)
		else:
			# if line of sight is removed and out of range, delete sightline altogether
			if body not in area_interface.area.get_overlapping_bodies():
				tracked_bodies[body].queue_free()
				tracked_bodies.erase(body)
	
	# Clear reached POIs
	for poi in poi_interface.get_all_pois():
		if (poi.global_position - global_position).length() < 10:
			poi.queue_free()

func body_entered(body: PhysicsBody2D) -> void:
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
