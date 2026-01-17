extends CharacterBody2D


const SPEED = 30.0

var freeze = false

func _physics_process(delta: float) -> void:
	if (freeze): return
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction.y *= 0.5
	direction = direction.normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _ready():
	SignalBus.connect("entered_minigame", freezeSelf)
	SignalBus.connect("exited_minigame", unfreezeSelf)

func freezeSelf():
	freeze = true

func unfreezeSelf():
	freeze = false
