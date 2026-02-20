extends Label
class_name DataEntries

var entries: Dictionary[String, String]
var states_map = {
	"STATE": Universal.show_entity_states
}

func _ready() -> void:
	update_text()

func update_text() -> void:
	if true not in states_map.values():
		text = ""
	else:
		text = "\n".join(entries.keys().map(
			func (key):
				if !states_map.has(key) or states_map[key]:
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
