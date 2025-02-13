extends Control

var screen_update_time := 0.3
var screen := "title"
var selection_icon := " <"

func _ready(): # Only starts once all nodes are ready
	if not FileAccess.file_exists("res://GAMEDATA.cfg"): # Displays Godot logo if first load
		await get_tree().create_timer(screen_update_time * 4).timeout
		$GodotImage.visible = true
		$GodotLabel.visible = true
		await get_tree().create_timer(screen_update_time * 12).timeout
		$GodotImage.visible = false
		$GodotLabel.visible = false
		await get_tree().create_timer(screen_update_time * 4).timeout
	$Title.toggle()
	await get_tree().create_timer(screen_update_time * 10).timeout
