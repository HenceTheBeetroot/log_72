extends State
class_name TrackPlayer

@export var sight_handler: SightHandler
@export var MOMENTUM: float = 0.0625
@export var MAXSPEED: float = 300

var target: Vector2

func _ready() -> void:
	MOMENTUM = MAXSPEED / (60 * MOMENTUM) # Converts MOMENTUM from seconds to distance per frame (for move_towards)

func Out():
	var distance: Vector2 = target - owner.position
	var speed = MAXSPEED * distance.length() / sight_handler.distance
	owner.velocity = owner.velocity.move_toward(distance.normalized() * speed, MOMENTUM) * 0.95 # slow upon approach
	if abs(owner.velocity.x) + abs(owner.velocity.y) < 10:
		owner.velocity = Vector2.ZERO
		return true
	return false

func Condition():
	return sight_handler.find_rand_in_group("player_main")

func PhysicsProcess(_delta: float):
	var player_pos = sight_handler.find_rand_in_group("player_main")
	if player_pos and player_pos.position:
		target = player_pos.position
		var direction = (target - owner.position).normalized()
		owner.velocity = owner.velocity.move_toward(direction * MAXSPEED, MOMENTUM)
	owner.move_and_slide()
