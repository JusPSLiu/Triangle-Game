extends Node2D
class_name scene_object

var behind : int = true
@onready var parent = get_parent()

@export var rightSideCoverOffset : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (parent):
		if (behind):
			# behind player, check if must go in front
			# offset if player is to the right
			var offsetPos = position.y
			if (parent.player_position.x > position.x):
				offsetPos += rightSideCoverOffset
			# check if should be in front of player
			if (parent.player_position.y < offsetPos):
				z_index =  parent.layerInFront
				behind = false
		else:
			# in front of player, check if go behind
			# offset if player is to the right
			var offsetPos = position.y
			if (parent.player_position.x > position.x):
				offsetPos += rightSideCoverOffset
			# check if should be behind player pos
			if (parent.player_position.y > position.y):
				z_index =  parent.layerBehind
				behind = true
