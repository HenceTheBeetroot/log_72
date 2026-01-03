extends RayCast2D
class_name SightLine

var target: PhysicsBody2D = null

func _ready() -> void:
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	if Universal.render_sightlines:
		var sightline_renderer = Node2D.new()
		sightline_renderer.set_script(load("res://scenes/debug/render_sightline.gd"))
		add_child(sightline_renderer)

func update_target() -> void:
	var entity = self
	# climb tree until we find the root entity node
	# yes this hurts me too but it works so shut up
	while !entity is Entity:
		entity = entity.get_parent()
	target_position = target.position - entity.position

func _physics_process(_delta: float) -> void:
	update_target()
