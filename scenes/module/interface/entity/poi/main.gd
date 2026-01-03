extends Node
class_name POIInterface

func create_poi(poi_name: String, poi_position: Vector2) -> Node2D:
	if get_node_or_null(poi_name): return null # fail if name is duplicate
	var new_poi := Node2D.new()
	new_poi.position = poi_position
	new_poi.name = poi_name
	if Universal.render_pois: new_poi.set_script(load("res://scenes/debug/render_point.gd"))
	add_child(new_poi)
	return new_poi

func get_poi(poi_name: String) -> Node2D:
	return get_node_or_null(poi_name)

func get_all_pois() -> Array[Node2D]:
	var array: Array[Node2D] = []
	array.assign(get_children())
	return array

func update_poi(poi_name: String, new_position: Vector2, create_if_null: bool = false) -> bool:
	var poi = get_poi(poi_name)
	if poi:
		poi.position = new_position
		return true
	else:
		if !create_if_null: return false
		return create_poi(poi_name, new_position) != null

func remove_poi(poi: Node2D) -> bool:
	if poi.get_parent() != self: return false
	poi.queue_free()
	return true
