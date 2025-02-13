extends Label

var type = "screen"
var shudder := 5

func _process(_delta):
	self.set_position(Vector2((randf() - 0.5) * shudder, (randf() - 0.5) * shudder))

func toggle():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
