extends Node2D
class_name scene_object

var behind : int = true
@onready var parent = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (parent):
		if (behind):
			# behind player, check if must go in front
			if (parent.player_position < position.y):
				z_index =  parent.layerInFront
				behind = false
		else:
			# in front of player, check if go behind
			if (parent.player_position > position.y):
				z_index =  parent.layerBehind
				behind = true
