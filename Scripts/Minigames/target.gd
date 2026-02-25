extends TextureRect
class_name target

@export var key = "copperKey"
@onready var animator : AnimationPlayer = $Paperclip/paperanimator
@onready var tutorial : AnimationPlayer = $tutorial/tutorial_fadein

var tutorialed = false

var layer = 0
var kids : Array[Control]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# load the kids
	for child in get_children():
		if (child is Spinny):
			kids.append(child)

func start():
	# reset the kids
	self_initialize(GlobalVariables.in_inventory(key))

func self_initialize(completed=false):
	if (completed):
		layer = kids.size()
		animator.play("nothing")
	else:
		animator.play("start")
		if (!tutorialed):
			tutorial.play("fadein")
	
	for child in kids:
		child.reset(completed)

func _input(event: InputEvent) -> void:
	if (event is InputEventKey):
		if (event.is_action_pressed("shove")):
			# skip if layer is invalid or reset animation is playing
			if (layer >= kids.size() or animator.is_playing()):
				return
			
			# tell the tutorial to stop
			if (!tutorialed):
				tutorial.play("fadeout")
				tutorialed = true
			
			# ask the child if right position
			if (kids[layer].stop()):
				layer += 1
			else:
				layer = 0
				start()
				animator.play("restart")
			
			if (layer >= kids.size()):
				animator.play("done")
				GlobalVariables.add_to_inventory("copperKey")
