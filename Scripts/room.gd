extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get the spawn location
	if (ResourceLoader.exists(GlobalVariables.prior_room)):
		var doors = $SceneObjects.find_children("*", "door")
		for child : door in doors:
			if (child.to_room == GlobalVariables.prior_room):
				$Player.global_position = child.entrance_point.global_position
