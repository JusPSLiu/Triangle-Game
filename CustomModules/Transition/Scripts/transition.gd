extends Control

# grab the child animation player
@onready var transitionPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	SignalBus.fade_to_level.connect(fadeToScene)

# fade to scene
func fadeToScene(scene : String):
	if (scene.is_empty() or !ResourceLoader.exists(scene)):
		print("ERROR, scene not found")
	fadeOut()
	GlobalVariables.prior_room = get_tree().current_scene.scene_file_path
	await transitionPlayer.animation_finished
	get_tree().change_scene_to_file(scene)

func fadeOut():
	transitionPlayer.play("FadeOut")

func fadeIn():
	transitionPlayer.play("FadeOut")
