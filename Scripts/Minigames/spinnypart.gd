extends TextureRect
class_name Spinny

@export var SPEED : float = -4.0
@export var tolerance : Vector2 = Vector2(-36, -92)
@export var stopAtDegree = -90

var state : int = 0
var currSpeed = SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match(state):
		0: # STATE 0; SPINNING
			currSpeed = lerp(currSpeed, SPEED, delta*4) # ACCELERATE
			rotation += delta * currSpeed # TURN
			while (rotation_degrees < -360):
				rotation_degrees += 360
		1: # STATE 1; FINISHING
			rotation += delta * SPEED
			if (rotation_degrees < stopAtDegree):
				rotation_degrees = stopAtDegree
				state = 2
				currSpeed = 0.0
		2: pass # STATE 2; DONE

func reset(completed = false):
	if (completed):
		state = 1
		self_modulate = Color.BLACK
	state = 0
	self_modulate = Color.WHITE

func stop() -> bool:
	if (rotation_degrees > tolerance.x or rotation_degrees < tolerance.y): return false
	state = 1 # SUCCESS; FINISHING STATE
	self_modulate = Color.BLACK
	# TODO: insert fx
	$CPUParticles2D.emitting = true
	return true
