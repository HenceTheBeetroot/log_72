extends Node
class_name StateHandler

var STATES : Array[State] = []
var ACTIVE : State

func _ready() -> void:
	for STATE in get_children():
		if STATE is State:
			STATES.append(STATE)
	if STATES:
		ACTIVE = STATES[0]

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

func _physics_process(delta: float) -> void: # literally the same except physicsprocess -_-
	if ACTIVE:
		if ACTIVE.Condition():
			ACTIVE.PhysicsProcess(delta)
		else:
			ACTIVE.Out()
			ACTIVE = null
	if not ACTIVE:
		for STATE in STATES:
			if STATE.Condition():
				ACTIVE = STATE
				ACTIVE.In()
				ACTIVE.PhysicsProcess(delta)
