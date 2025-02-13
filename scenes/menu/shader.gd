extends ColorRect

func _ready():
	add_to_group("PERSIST")

func toggle():
	visible = !visible

func SAVE():
	return {"parent" : get_parent().get_path(),
			"visible" : visible}
