extends Node

var PATH := "res://GAMEDATA.cfg"

func SAVEALL():
	var config := ConfigFile.new()
	var nodes := get_tree().get_nodes_in_group("PERSIST")
	for node: Node in nodes:
		if !node.has_method("SAVE"):
			print("WARNING: persistent node '%s' is missing a SAVE function, skipped" % node.get_path())
			continue
		var data: Dictionary = node.SAVE()
		if config.has_section(node.get_path()):
			print("WARNING: node '%s' is duplicate, skipped" % node.get_path())
			continue
		for key: String in data.keys():
			if config.has_section_key(node.get_path(), key):
				print("WARNING: variant '%s' (in node '%s') is duplicate, skipped" % [key, node.get_path()])
				continue
			config.set_value(node.get_path(), key, data[key])
	config.save(PATH)

func LOADALL():
	if not FileAccess.file_exists(PATH):
		print("save file not found, load skipped")
		return
	
	var GAMEDATA = FileAccess.open(PATH, FileAccess.READ)
	if not GAMEDATA.get_length():
		print("save file empty, load skipped")
		return
	
	var config := ConfigFile.new()
	var err := config.load(PATH)
	if err != OK:
		print("error '%s' loading config file!" % err)
	
	for node_path in config.get_sections():
		var node := get_node(node_path)
		for key in config.get_section_keys(node_path):
			node.set(key, config.get_value(node_path, key))
