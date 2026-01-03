extends Node
class_name StateHandler

var STATES : Array[State] = []
var ACTIVE : State
var debug_text : Label

func _ready() -> void:
	owner.add_to_group("state_entity")
	for STATE in get_children():
		if STATE is State:
			STATES.append(STATE)
	if STATES:
		ACTIVE = STATES[0]
	if Universal.show_entity_states: # displays current entity state in debug mode
		debug_text = Label.new()
		debug_text.text = "UNDEFINED"
		owner.call_deferred("add_child", debug_text)

func _process(delta: float) -> void:
	if ACTIVE: # if there is a current state
		if ACTIVE.Condition(): # and that state is still valid
			ACTIVE.Process(delta) # run state
		elif ACTIVE.Out(): # leave state
			ACTIVE = null
	if not ACTIVE: # if there is no current state (not an else in case current state is removed in ACTIVE)
		for STATE in STATES: # find first valid state
			if STATE.Condition():
				if STATE.In():
					ACTIVE = STATE # enter state
					ACTIVE.Process(delta) # run new state
				break
	if Universal.show_entity_states:
		debug_text.text = String(ACTIVE.name) if ACTIVE else "NULL"

func _physics_process(delta: float) -> void:
	if ACTIVE: ACTIVE.PhysicsProcess(delta)
