extends State
class_name PlayerMove

@export var MOMENTUM : float = 0.0625
@export var MAXSPEED : float = 300

func _ready() -> void:
	MOMENTUM = MAXSPEED / (60 * MOMENTUM) # Converts MOMENTUM from seconds to distance per frame (for move_towards)

func In():
	owner.sprite_handler.find("legs").begin_animation("run")
	return true

func Out():
	owner.sprite_handler.find("legs").end_animation()
	return true

func Condition(): # if entity is moving or wants to move
	return owner.velocity or Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()

func PhysicsProcess(_delta: float): # set entity velocity (in Process because this doesn't actually move the entity)
	owner.target = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if owner.target.length() > 0.1: owner.update_legs_facing(owner.target)
	owner.velocity = owner.velocity.move_toward(owner.target * MAXSPEED, MOMENTUM)
	owner.move_and_slide()
