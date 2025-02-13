extends Label

@export var target: String
var type := "scene"

func toggle():
	var scene: Node = load("res://scenes/" + target + ".tscn").instantiate()
	var root := get_owner()
	root.get_node(root.screen).toggle()
	root.add_child(scene)
