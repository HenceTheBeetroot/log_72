extends State
class_name PlayerMove

@export var MOMENTUM: float = 0.0625
@export var MAXSPEED: float = 300

func _ready() -> void:
	MOMENTUM = MAXSPEED / (60 * MOMENTUM) # Converts MOMENTUM from seconds to distance per frame (for move_towards)

func Condition():
	return owner.velocity or Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()

func Process(delta: float):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	owner.velocity = owner.velocity.move_toward(direction * MAXSPEED, MOMENTUM)
