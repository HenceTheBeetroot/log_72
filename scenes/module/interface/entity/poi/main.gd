extends Node
class_name POIInterface

func create_poi(poi_name: String, poi_position: Vector2) -> POI:
	if get_node_or_null(poi_name): return null # fail if name is duplicate
	var new_poi := POI.new()
	new_poi.position = poi_position
	new_poi.name = poi_name
	if Universal.render_pois:
		var render_circle = Node2D.new()
		render_circle.set_script(load("res://scenes/debug/render_point.gd"))
		new_poi.add_child(render_circle)
	add_child(new_poi)
	return new_poi

func get_poi(poi_name: String) -> POI:
	return get_node_or_null(poi_name)

func get_all_pois() -> Array[POI]:
	var array: Array[POI] = []
	array.assign(get_children())
	return array

func get_custom_data(poi_name: String, key: String) -> Variant:
	return get_poi(poi_name).get_custom_data(key)
	
func set_custom_data(poi_name: String, key: String, value: Variant) -> void:
	if !get_poi(poi_name):
		push_error("Attempted to set data of nonexistent POI " + poi_name)
		return
	get_poi(poi_name).set_custom_data(key, value)

func update_poi(poi_name: String, new_position: Vector2, create_if_null: bool = false) -> bool:
	var poi = get_poi(poi_name)
	if poi:
		poi.position = new_position
		return true
	else:
		if !create_if_null: return false
		return create_poi(poi_name, new_position) != null

func remove_poi(poi: POI) -> bool:
	if poi.get_parent() != self: return false
	poi.queue_free()
	return true
