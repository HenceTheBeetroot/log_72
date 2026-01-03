extends Node2D
class_name SightLineInterface

func create_sightline(sightline_name: String, body: PhysicsBody2D) -> RayCast2D:
	if get_node_or_null(sightline_name): return null
	var sightline := SightLine.new()
	sightline.position = Vector2.ZERO
	sightline.target = body
	sightline.name = sightline_name
	add_child(sightline)
	return sightline

func get_sightline(sightline_name: String) -> RayCast2D:
	return get_node_or_null(sightline_name)

func update_sightline(sightline_name: String, new_body: PhysicsBody2D, create_if_null: bool = false) -> bool:
	var sightline = get_sightline(sightline_name)
	if sightline:
		sightline.target = new_body
		return true
	else:
		if !create_if_null: return false
		return create_sightline(sightline_name, new_body) != null

func remove_sightline(sightline: RayCast2D) -> bool:
	if sightline.get_parent() != self: return false
	sightline.queue_free()
	return true
