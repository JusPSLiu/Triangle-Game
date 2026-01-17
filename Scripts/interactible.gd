extends Node2D

var player_in : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _self_action():
	print("no, u")

func _input(event: InputEvent) -> void:
	if (!player_in): return
	if (event.is_action_pressed("interact")):
		_self_action()

func _on_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		$Prompt.show()
		player_in = true


func _on_detection_body_exited(body: Node2D) -> void:
	if (body.is_in_group("player")):
		$Prompt.hide()
		player_in = false
