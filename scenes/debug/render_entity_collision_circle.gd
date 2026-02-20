extends Node2D
class_name DebugRenderEntityCollisionCircle

@onready var parent: Entity = get_parent()
@onready var hitbox: HitboxManager = parent.get_node("HitboxManager")

func _draw() -> void:
	if hitbox == null:
		push_error("Attempted to render collision circle for entity without hitbox manager")
	else:
		draw_circle(Vector2.ZERO, hitbox.shape.radius, Color.DARK_ORANGE, false, 2)
