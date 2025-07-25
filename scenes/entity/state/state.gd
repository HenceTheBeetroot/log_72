extends Node
class_name State

func In() -> bool:
	# Attempt to enter state
	return true

func Out() -> bool:
	# Attempt to exit state
	# Return true if state is finished
	# Return false if state still needs to run
	return true

func Condition() -> bool:
	# Should we attempt to enter this state?
	return false

func Process(_delta: float):
	# Functions to run alongside _process()
	pass

func PhysicsProcess(_delta: float):
	# Functions to run alongside _physics_process()
	pass
