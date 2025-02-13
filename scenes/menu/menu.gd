extends Control

var selected := 0
var max_len_button := 0

@onready var GET := $".."
@onready var screen_update_time: float = GET.screen_update_time
@onready var selection_icon: String = GET.selection_icon
@onready var Buttons := $"Buttons".find_children("*")
@onready var Title := $"../TitleText"
@export var title_str: String

func all_ready():
	for child in get_children():
		if child.has_method("all_ready"):
			child.all_ready()

func _ready():
	for button in Buttons:
		max_len_button = max(len(button.get_text()) + (8 if button.type == "toggle" else 0), max_len_button)
		button.set_position(Vector2(0,-50 * (len(Buttons) - button.get_index() - 1)))

func toggle():
	GET.screen = name
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
	visible = true
	
	await get_tree().create_timer(screen_update_time).timeout
	Title.set_text(title_str)
	Title.visible = true
	for button in Buttons:
		await get_tree().create_timer(screen_update_time).timeout
		button.visible = true

func _input(event):
	if GET.screen == name and not event is InputEventMouse and not event.is_echo() and Buttons and screen_update_time:
		if Buttons and screen_update_time:
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
					
					visible = false
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
