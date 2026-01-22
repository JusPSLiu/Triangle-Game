extends Control
class_name papery

signal inc_state

@export var placement = 0
var mouse_over : bool = false
var moving : bool = false
var mouseOffset : Vector2 = Vector2.ZERO

var initState : Vector3 = Vector3.ZERO

@onready var init_pivot : Vector2 = pivot_offset

func _ready():
	initState.x = global_position.x
	initState.y = global_position.y

# starting, pick random rotation
func start():
	rotation = randf_range(-0.2,0.2)
	z_index = 20-placement
	initState.z = rotation
	position.x = initState.x
	position.y = initState.y
	update_state()

func update_state():
	if (get_parent().currState == placement):
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		mouse_default_cursor_shape = Control.CURSOR_ARROW

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (moving):
		if (Input.is_action_pressed("click")):
			global_position = get_global_mouse_position() + mouseOffset
			rotation = initState.z - (0.1)*(initState.x-global_position.x)*0.01
		else:
			moving = false
			if (abs(global_position.x - 315.0) > 200):
				# if dragged far enough away, can shoot it off
				# to the right if x over 480 or left if under 480
				if (position.x > 315.0):
					position.x = lerp(position.x, 1200.0, 0.25)
				else: position.x = lerp(position.x, -600.0, 0.25)
				emit_signal("inc_state")
	elif (abs(global_position.x - 315.0) > 200):
		# if dragged far enough away, can shoot it off
		if (position.x > 315.0):
			position.x = lerp(position.x, 1200.0, 0.25)
		else: position.x = lerp(position.x, -600.0, 0.25)
	else:
		if (global_position.x != initState.x):
			global_position.x = lerp(global_position.x, initState.x, 0.25)
		if (global_position.y != initState.y):
			global_position.y = lerp(global_position.y, initState.y, 0.25)
		if (rotation != initState.z):
			rotation = lerp(rotation, initState.z, 0.25)
			pivot_offset = init_pivot

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false

func _input(event: InputEvent) -> void:
	if (get_parent().currState == placement and mouse_over and event.is_action_pressed("click")):
		moving = true
		mouseOffset = global_position - get_global_mouse_position()
		pivot_offset = -mouseOffset
