extends Node2D
class_name SpriteHandler

var sprites : Dictionary[String, Sprite2D] = {}

func _ready():
	for child : Sprite2D in get_children():
		sprites.set(child.get_name().to_lower(), child)

func find(sprite : String) -> Sprite2D:
	return sprites[sprite.to_lower()]
