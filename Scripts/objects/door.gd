extends interactible_object
class_name door

@export var to_room : String = ""
@export var entrance_point : Node2D
@export var keys : Array[String]

# setup
func _ready():
	# hide prompt
	$Prompt.hide()

# ACTION. change to level
func _self_action():
	for key in keys:
		if (!GlobalVariables.in_inventory(key)):
			if (!$Prompt2/AnimationPlayer.is_playing()):
				$Prompt2/AnimationPlayer.play("needkey")
			return
	# only continue if prompt is visible
	if (!$Prompt.visible): return
	SignalBus.fade_to_level.emit(to_room)
	$Prompt.hide()
