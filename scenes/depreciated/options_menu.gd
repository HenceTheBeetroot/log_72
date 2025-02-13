extends Control

var selected := 0
var max_len_button := 0

@onready var GET := $".."
@onready var screen_update_time: float = GET.screen_update_time
@onready var selection_icon: String = GET.selection_icon
@onready var Buttons := $"Buttons".find_children("*")
@onready var Title := $"../TitleText"

func all_ready():
	for button in Buttons:
		if button.get("text_processed") == false:
			return
	var max_button: Label
	for button in Buttons:
		max_button = button if len(button.get_text()) > max_len_button else max_button
		max_len_button = len(max_button.get_text()) if max_button == button else max_len_button
		button.set_position(Vector2(0,-50 * (len(Buttons) - button.get_index() - 1)))
	if max_button.type == "toggle":
		max_len_button += 1
		max_button.set_text(max_button.get_text() + " ")

func toggle():
	GET.screen = "options"
	selected = 0
	for button in Buttons:
		button.set_text(button.get_text().replace(selection_icon, ""))
	var spacing := ""
	for i in range(max_len_button - len(Buttons[selected].get_text())):
		spacing += " "
	Buttons[selected].set_text(
		Buttons[selected].get_text()
		+ spacing
		+ selection_icon
	)
	self.visible = true
	
	Title.set_text("options")
	Title.visible = true
	for button in Buttons:
		await get_tree().create_timer(screen_update_time).timeout
		button.visible = true

func _input(event):
	if GET.screen == "options" and not event is InputEventMouse and not event.is_echo() and Buttons and screen_update_time:
		if Input.is_action_just_pressed("select"):
			if Buttons[selected].type == "screen":
				Title.visible = false
				for i in range(len(Buttons)):
					if i == selected:
						continue
					await get_tree().create_timer(screen_update_time).timeout
					Buttons[i].visible = false
				await get_tree().create_timer(2 * screen_update_time).timeout
				Buttons[selected].visible = false
				
				self.visible = false
			Buttons[selected].toggle()
		
		if Title.visible:
			if Input.is_action_just_pressed("up"):
				selected = ( selected - 1 ) % len(Buttons)
			elif Input.is_action_just_pressed("down"):
				selected = (selected + 1) % len(Buttons)
			if selected < 0:
				selected = len(Buttons) + selected
				
			for button in Buttons:
				button.set_text(button.get_text().replace(selection_icon, ""))
			
			var spacing = ""
			for i in range(max_len_button - len(Buttons[selected].get_text())):
				spacing += " "
			Buttons[selected].set_text(
				Buttons[selected].get_text()
				+ spacing
				+ selection_icon
			)
