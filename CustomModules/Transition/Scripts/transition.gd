extends Control

# grab the child animation player
@onready var transitionPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()

# fade to scene
func fadeToScene(scene : String):
	if (!ResourceLoader.exists(scene)):
		print("ERROR, scene not found")
	fadeOut()
	await transitionPlayer.animation_finished
	get_tree().change_scene_to_file(scene)

func fadeOut():
	transitionPlayer.play("FadeOut")

func fadeIn():
	transitionPlayer.play("FadeOut")
