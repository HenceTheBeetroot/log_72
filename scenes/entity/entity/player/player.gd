extends Entity

@export var sprite_handler : SpriteHandler

# For movement
var target := Vector2.DOWN

# For sprites
var body_facing := Vector2.DOWN
var legs_facing := Vector2.DOWN

func update_body_facing(new: Vector2):
	body_facing = body_facing.move_toward(new, 0.25)
	
func update_legs_facing(new: Vector2):
	legs_facing = legs_facing.move_toward(new, 0.25)

func _process(_delta):
	update_body_facing((get_global_mouse_position() - position).normalized())
	sprite_handler.find("body").angle = body_facing.angle_to(Vector2.DOWN)
	sprite_handler.find("legs").angle = legs_facing.angle_to(Vector2.DOWN)
