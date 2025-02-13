extends Node

var state := "menu" # Set game state to Menu

func _ready(override: Array[Node] = []):
	""" Automatically calls all child functions' all_ready() commands. """
	if not override:
		get_tree().set_auto_accept_quit(false)
		$DataManager.LOADALL()
		override = self.get_children()
	for node in override: # Calls all_ready() functions in all children
		if node.has_method("all_ready"):
			node.all_ready()
		if len(node.get_children()) > 0:
			_ready(node.get_children()) # Recursive for node children

func _notification(what):
	""" Catches CLOSE attempts to save first. """
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		$DataManager.SAVEALL()
		get_tree().call_deferred("quit")
