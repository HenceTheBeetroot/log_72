extends Sprite2D
class_name OctHalfSprite2D
## A handler class for eight-directional sprites composed of five flipping animations.

## The default row to use when no animation is playing.
@export var default: int = 0
## Any defined animations to use.
## [br][br]
## Leave blank for single-row animations (just rotation).
## [br][br]
## For complex animation files, use the following, separated by semicolons:
## [br][br]
## For single-row animations:
## [br]
## animation_name=row
## [br][br]
## For animations that travel along a range:
## [br]
## animation_name=[first_in_range-last_in_range]
## [br][br]
## For animations that jump between rows:
## [br]
## animation_name=[row_1,row_2,row_3...]
## [br][br]
## Example (three-row legs sheet, with jumping on row 0, running through 0-2, and falling alternating between 0 and 2):
## [br]
## jump=0;run=[0-2];fall=[0,2]
@export var animation_data: String

var animations: Dictionary[String, Array]

var current_animation: Array[int] = [default]
var current_frame := 0
var frame_timer: SceneTreeTimer

## The angle that this sprite should render at.
## Should be CCW from Vector2.DOWN.
var angle : float:
	get: return angle
	set(value):
		value = fposmod(value, 2 * PI) # shift angle between 0 and 2 * PI
		flip_h = value > PI
		if flip_h:
			value = 2 * PI - value # convert value from CCW angle from Vector2.DOWN to shortest angle
		
		angle = value

func _ready():
	# Parse animation data
	for animation in animation_data.split(";", false):
		var full_data := animation.split("=")
		var name := full_data[0]
		var data := full_data[1]
		var data_array: Array[int] = []
		if data.contains("["):
			data = data.substr(1, data.length() - 2)
			if data.contains("-"):
				var start = int(data.substr(0, data.find("-")))
				var end = int(data.substr(data.find("-") + 1))
				for frame in range(start, end + 1):
					data_array.append(frame)
			else:
				for frame in data.split(","):
					data_array.append(int(frame))
		else:
			data_array = [int(data)]
		animations.set(name, data_array)

func loop():
	frame_coords.x = current_animation[current_frame]
	current_frame = (current_frame + 1) % current_animation.size()

func begin_animation(animation_name: String):
	current_animation = animations[animation_name]
	current_frame = 0

func end_animation():
	current_animation = [default]
	current_frame = 0

func _process(delta):
	# Determines the appropriate sprite given the angle
	# Multiplied by 4.99 instead of 5 so that up (PI) returns 0 (up sprite) instead of -1 (invalid sprite)
	frame_coords.y = 4 - floor(4.99 * angle / PI)
	if !frame_timer || frame_timer.get_time_left() == 0:
		frame_timer = get_tree().create_timer(0.1)
		loop()
