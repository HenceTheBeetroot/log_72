extends TileMapLayer

const RAISED_WALLS_TEXTURE := preload("uid://5qiqja8qajlx")

var RAISED_WALLS_SPRITES := Node2D.new()

func _ready() -> void:
	add_child(RAISED_WALLS_SPRITES)
	var used_cells = get_used_cells()
	used_cells.sort()
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = RAISED_WALLS_TEXTURE
	for coords in used_cells:
		var texture_node: Sprite2D
		
		# Create lower trim
		if coords + Vector2i.LEFT in used_cells and coords + Vector2i.RIGHT in used_cells:
			# Connecting on both
			atlas_texture.region = Rect2i(64, 160, 64, 64)
		elif coords + Vector2i.LEFT in used_cells:
			# Connected only on left
			atlas_texture.region = Rect2i(128, 160, 64, 64)
		elif coords + Vector2i.RIGHT in used_cells:
			# Connected only on right
			atlas_texture.region = Rect2i(0, 160, 64, 64)
		else:
			# Connected on neither
			atlas_texture.region = Rect2i(192, 160, 64, 64)
		if coords + Vector2i.DOWN in used_cells:
			# If there is a wall below
			atlas_texture.region = Rect2i(Vector2i(atlas_texture.region.position.x, 128), atlas_texture.region.size)
		texture_node = Sprite2D.new()
		texture_node.position = coords * 64 + Vector2i(32, 32)
		texture_node.texture = atlas_texture.duplicate()
		RAISED_WALLS_SPRITES.add_child(texture_node)
		
		# Create main wall
		if coords + Vector2i.LEFT in used_cells and coords + Vector2i.RIGHT in used_cells:
			# Connecting on both
			atlas_texture.region = Rect2(64, 0, 64, 128)
		elif coords + Vector2i.LEFT in used_cells:
			# Connected only on left
			atlas_texture.region = Rect2(128, 0, 64, 128)
		elif coords + Vector2i.RIGHT in used_cells:
			# Connected only on right
			atlas_texture.region = Rect2(0, 0, 64, 128)
		else:
			# Connected on neither
			atlas_texture.region = Rect2(192, 0, 64, 128)
		texture_node = Sprite2D.new()
		texture_node.position = coords * 64 + Vector2i(32, -32)
		texture_node.texture = atlas_texture.duplicate()
		RAISED_WALLS_SPRITES.add_child(texture_node)

func _notification(what: int) -> void:
	# Handle freeing children
	if (what == NOTIFICATION_PREDELETE):
		for child in RAISED_WALLS_SPRITES.get_children():
			child.queue_free()
		RAISED_WALLS_SPRITES.queue_free()
