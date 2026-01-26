extends scene_object
class_name interactible_object

@export var minigame : Control
@export var disappearWhen : String
var player_in : bool = false

# setup
func _ready():
	# if no minigame give error
	if (minigame == null):
		print_debug("ERROR, NO MINIGAME FOUND")
	# hide prompt and connect signal
	$Prompt.hide()
	SignalBus.connect("exited_minigame", show_prompt)
	
	calculateBoundary()
	if (disappearWhen.length() > 0):
		if (GlobalVariables.in_inventory(disappearWhen)):
			hide()

# ACTION. enter the minigame
func _self_action():
	# only continue if prompt is visible
	if (!$Prompt.visible): return
	# if no minigame give error
	if (minigame == null):
		print_debug("ERROR, NO MINIGAME FOUND")
		return
	# enter the minigame
	minigame._enter()
	$Prompt.hide()

# input
func _input(event: InputEvent) -> void:
	if (!player_in): return
	if (event.is_action_pressed("interact")):
		_self_action()

# player detection
func _on_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		player_in = true
		show_prompt()

# player detection
func _on_detection_body_exited(body: Node2D) -> void:
	if (body.is_in_group("player")):
		$Prompt.hide()
		player_in = false

# function for signal use only
func show_prompt():
	if (player_in):
		$Prompt.show()
	if (disappearWhen.length() > 0):
		if (GlobalVariables.in_inventory(disappearWhen)):
			hide()
