extends Control
class_name papery

signal inc_state

@export var placement = 0
@export var rate : float = 0.1
var mouse_over : bool = false
var moving : bool = false
var mouseOffset : Vector2 = Vector2.ZERO

var startState : Vector2 = Vector2.ZERO
var initState : Vector3 = Vector3.ZERO

@onready var init_pivot : Vector2 = pivot_offset

func _ready():
	startState.x = global_position.x
	startState.y = global_position.y

# starting, pick random rotation
func start():
	# reset to init state
	set_global_position(Vector2(startState.x, startState.y))
	# rotate randomly
	rotation = randf_range(-0.2,0.2)
	z_index = 20-placement
	# set the init rotated state
	initState.x = global_position.x
	initState.y = global_position.y
	initState.z = rotation
	
	# update state
	update_state()

func update_state():
	if (get_parent().currState == placement):
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		mouse_default_cursor_shape = Control.CURSOR_ARROW
		if (get_parent().currState > placement and abs(global_position.x - initState.x) <= 200):
			position.x = 1200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (moving):
		if (Input.is_action_pressed("click")):
			global_position = get_global_mouse_position() + mouseOffset
			rotation = initState.z - (0.1)*(initState.x-global_position.x)*0.01
		else:
			moving = false
			if (abs(global_position.x - initState.x) > 200):
				# if dragged far enough away, can shoot it off
				# to the right if x over 480 or left if under 480
				if (position.x > initState.x):
					position.x = lerp(position.x, 1200.0, rate)
				else: position.x = lerp(position.x, -600.0, rate)
				inc_state.emit(placement)
	elif (abs(global_position.x - initState.x) > 200):
		# brute force failsafe because of a glitch i dont feel like fixing
		if (get_parent().currState <= placement):
			inc_state.emit(placement)
		# if dragged far enough away, can shoot it off
		if (position.x > initState.x):
			position.x = lerp(position.x, 1200.0, rate)
		else: position.x = lerp(position.x, -600.0, rate)
		if (abs(global_position.y-initState.y) > 2):
			global_position.y = lerp(global_position.y, initState.y, rate)
	else:
		if (abs(global_position.x-initState.x) > 2):
			global_position.x = lerp(global_position.x, initState.x, rate)
		if (abs(global_position.y-initState.y) > 2):
			global_position.y = lerp(global_position.y, initState.y, rate)
		if (abs(rotation-initState.z) > 0.005):
			rotation = lerp(rotation, initState.z, rate)
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
