extends TileMapLayer

func _ready() -> void:
	var placed_tiles := get_used_cells()
	for tile : Vector2i in placed_tiles:
		var neighbors := get_surrounding_cells(tile)
		for neighbor : Vector2i in neighbors:
			if (get_cell_source_id(neighbor) == -1):
				set_cell(neighbor, 0, Vector2i(4, 0))
				print("PLACING AT ", neighbor)
