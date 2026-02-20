extends Node2D
class_name DebugRenderPoint

func _draw() -> void:
	draw_circle(Vector2.ZERO, 5, Color.GREEN_YELLOW, false, 2)
	var parent: POI = get_parent()
