extends Label
class_name DataEntries

var entries: Dictionary[String, String]

func _ready() -> void:
	update_text()

func update_text() -> void:
	text = "\n".join(entries.keys().map(
		func (key):
			var debug_states = {
				"STATE": Universal.show_entity_states
			}
			if !debug_states.has(key) or debug_states[key]:
				return key + " : " + entries[key]
	))

func set_entry(key: String, value: String) -> void:
	if !entries.has(key) or entries[key] != value:
		entries[key] = value
		update_text()

func get_entry(key: String) -> String:
	return entries[key]

func remove_entry(key: String) -> void:
	if entries.erase(key): update_text()
