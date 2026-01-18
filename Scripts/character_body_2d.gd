extends CharacterBody2D


const SPEED = 50.0

var freeze = false

func _physics_process(delta: float) -> void:
	if (freeze): return
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = direction.rotated(deg_to_rad(45))
	direction.y *= 0.5
	direction = direction.normalized()
	if direction:
		velocity.x = lerpf(velocity.x, direction.x*SPEED, 0.5)
		velocity.y = lerpf(velocity.y, direction.y*SPEED, 0.5)
	else:
		velocity.x = lerpf(velocity.x, 0, 0.5)
		velocity.y = lerpf(velocity.y, 0, 0.5)
	print(direction)

	move_and_slide()

func _ready():
	SignalBus.connect("entered_minigame", freezeSelf)
	SignalBus.connect("exited_minigame", unfreezeSelf)
	$DustEffects.emitting = true

func freezeSelf():
	freeze = true

func unfreezeSelf():
	freeze = false
