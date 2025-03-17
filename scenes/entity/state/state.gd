extends Node
class_name State

func In() -> bool:
	return true

func Out() -> bool:
	return true

func Condition() -> bool:
	return false

func Process(delta: float):
	pass

func PhysicsProcess(delta: float):
	pass
