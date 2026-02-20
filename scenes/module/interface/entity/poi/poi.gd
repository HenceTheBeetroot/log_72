extends Node2D
class_name POI

var custom_data: Dictionary[String, Variant] = {}

func get_custom_data(key: String) -> Variant:
	return custom_data[key] if key in custom_data.keys() else null

func set_custom_data(key: String, value: Variant) -> void:
	custom_data[key] = value

func remove_custom_data(key: String) -> Variant:
	var returner: Variant = custom_data[key]
	custom_data.erase(key)
	return returner

func add_nested_poi(new_name: String) -> bool:
	if new_name not in get_nested_pois().map(func(poi: POI): return poi.name):
		var poi = POI.new()
		poi.name = new_name
		add_child(poi)
		return true
	return false

func free_nested_poi(remove_name: String) -> bool:
	for child in get_nested_pois():
		if child.name == remove_name:
			child.queue_free()
			return true
	return false

func dissolve_nested_poi(remove_name: String) -> bool:
	for child in get_nested_pois():
		if child.name == remove_name:
			child.dissolve()
			return true
	return false

func get_nested_poi(get_name: String) -> POI:
	var found_poi: POI = get_node(NodePath(name))
	if found_poi: return found_poi
	else:
		for child_poi: POI in get_children():
			found_poi = child_poi.get_nested_poi(get_name)
			if found_poi: return found_poi
	return null

func get_nested_pois() -> Array[POI]:
	var pois: Array[POI]
	get_children().assign(pois)
	for child_poi: POI in get_children():
		pois.append(child_poi.get_nested_pois())
	return pois

func dissolve() -> void:
	for child in get_children():
		child.reparent(get_parent())
	queue_free()
