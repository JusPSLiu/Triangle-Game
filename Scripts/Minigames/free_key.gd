extends Control
class_name freekey

@export var key : String
@export var animator : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start():
	if (GlobalVariables.in_inventory(key)): return
	
	GlobalVariables.add_to_inventory(key)
	if (animator is AnimationPlayer):
		animator.play("key_get")
