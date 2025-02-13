extends Label

@export var target: Node
var type := "screen"

func toggle():
	target.toggle()
