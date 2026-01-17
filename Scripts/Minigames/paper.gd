extends Control

@export var placement = 0
var mouse_over : bool = false
var moving : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# starting, pick random rotation
func start():
	rotation = randf_range(-0.2,0.2)
	z_index = placement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(mouse_over)
	if (moving):

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false

func _input(event: InputEvent) -> void:
	if (mouse_over and event.is_action_pressed("click")):
		moving = true
