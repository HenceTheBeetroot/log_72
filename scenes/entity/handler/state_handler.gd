extends Node
class_name StateHandler

var STATES : Array[State] = []
var ACTIVE : State
var debug_text : Label

func _ready() -> void:
	for STATE in get_children():
		if STATE is State:
			STATES.append(STATE)
	if STATES:
		ACTIVE = STATES[0]
	if Universal.DEBUG:
		debug_text = Label.new()
		debug_text.text = "UNDEFINED"
		print(debug_text)
		print(owner)
		owner.add_child.call_deferred(debug_text)
		print(owner.get_children())
		print(debug_text.get_parent())

func _process(delta: float) -> void:
	if ACTIVE: # if there is a current state
		if ACTIVE.Condition(): # and that state is still valid
			ACTIVE.Process(delta) # run state
		else:
			ACTIVE.Out() # leave state
			ACTIVE = null
	if not ACTIVE: # if there is no current state
		for STATE in STATES: # find first valid state
			if STATE.Condition():
				ACTIVE = STATE # enter state
				ACTIVE.In()
				ACTIVE.Process(delta) # run new state
	if Universal.DEBUG:
		debug_text.text = (ACTIVE.name if ACTIVE else "NULL")

func _physics_process(delta: float) -> void:
	if ACTIVE: # run physicsprocess of state, but do not update state
		ACTIVE.PhysicsProcess(delta)
