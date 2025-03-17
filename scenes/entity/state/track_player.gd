extends State
class_name TrackPlayer

@export var sight: SightHandler
@export var MOMENTUM: float = 0.0625
@export var MAXSPEED: float = 300

var target: Vector2

func _ready() -> void:
	MOMENTUM = MAXSPEED / (60 * MOMENTUM) # Converts MOMENTUM from seconds to distance per frame (for move_towards)

func Out():
	var distance: Vector2 = target - owner.position
	if distance.length() > 10:
		var speed = max(MAXSPEED * distance.length() / sight.range, MAXSPEED / 4)
		owner.velocity = owner.velocity.move_toward(distance.normalized() * speed, MOMENTUM) # slow upon approach
	else:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO, MOMENTUM / 8) # slow to stop
		if abs(owner.velocity.x) + abs(owner.velocity.y) < 1:
			owner.velocity = Vector2.ZERO
			return true
	return false

func Condition():
	return sight.find_rand_in_group("player_main")

func Process(delta: float):
	var new_pos = sight.find_rand_in_group("player_main").position
	if new_pos: target = new_pos
	var direction = (target - owner.position).normalized()
	owner.velocity = owner.velocity.move_toward(direction * MAXSPEED, MOMENTUM)
