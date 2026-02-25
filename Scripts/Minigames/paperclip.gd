extends TextureRect

@export var positions : Array[Vector2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var state = get_parent().layer
	state = clamp(state, 0, positions.size())
	position = lerp(position, positions[state], delta * 24)
