extends Label

@export var path: String
var type := "toggle"
var target: Node
var text_processed = false

func all_ready():
	target = get_tree().get_root()
	for layer in path.split("/"):
		target = target.get_children().filter(func(item: Node): return layer == item.name)[0]
	target.visibility_changed.connect(update)
	update()
	text_processed = true
	$"../..".all_ready()

func toggle():
	target.toggle()

func update():
	self.set_text(self.get_text().substr(0, self.get_text().find(" [")) + " [%s]" % target.visible)
