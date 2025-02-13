extends Node

@onready var PARENT := $".."

func all_ready():
	for button in PARENT.Buttons:
		if button.get("text_processed") == false:
			return
	var max_button: Label
	for button in PARENT.Buttons:
		max_button = button if len(button.get_text()) > PARENT.max_len_button else max_button
		PARENT.max_len_button = len(max_button.get_text()) if max_button == button else PARENT.max_len_button
		button.set_position(Vector2(0,-50 * (len(PARENT.Buttons) - button.get_index() - 1)))
	if max_button.type == "toggle":
		PARENT.max_len_button += 1
		max_button.set_text(max_button.get_text() + " ")
