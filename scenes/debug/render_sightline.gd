extends Node2D
class_name DebugRenderSightline

func _process(_delta) -> void:
	queue_redraw()

func _draw() -> void:
	draw_line(get_parent().position, get_parent().target_position, Color.CRIMSON, 2)
