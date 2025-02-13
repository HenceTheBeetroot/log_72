extends Label

var type = "screen"

@onready var target = $"../.."

func toggle():
	target.toggle()
