extends CharacterBody2D

const SPEED = 50.0

var freeze = false
var currentDirection = 1

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
	move_and_slide()
	
	set_animation(direction)

func _ready():
	SignalBus.connect("entered_minigame", freezeSelf)
	SignalBus.connect("exited_minigame", unfreezeSelf)
	$DustEffects.restart()
	$CloseupDust.restart()
	$CloseupDust2.restart()

func freezeSelf():
	freeze = true

func unfreezeSelf():
	freeze = false

func set_animation(direction : Vector2):
	if (direction == Vector2.ZERO): return
	
	# THIS IS BAD PRACTICE. ANYBODY ELSE LOOKING AT THIS JAM CODE SHOULD SHIELD THEIR EYES NOW
	# THE ONLY REASON IM DOING THIS IS BECAUSE IM TOO LAZY TO SET UP A WHOLE ANIMATION TREE FOR THIS GAME
	if (direction.x > 0):
		if (direction.y > 0):
			# \ SOUTHEAST
			$AnimatedSprite2D.play("stand_d")
			$AnimatedSprite2D.flip_h = true
		elif (direction.y < 0):
			# / NORTHEAST
			$AnimatedSprite2D.play("stand_d")
			$AnimatedSprite2D.flip_h = false
		else:
			# - EAST
			$AnimatedSprite2D.play("stand_d")
			$AnimatedSprite2D.flip_h = false
	elif (direction.x < 0):
		if (direction.y > 0):
			# / SOUTHWEST
			$AnimatedSprite2D.play("stand_d")
			$AnimatedSprite2D.flip_h = false
		elif (direction.y < 0):
			# \ NORTHWEST
			$AnimatedSprite2D.play("stand_d")
			$AnimatedSprite2D.flip_h = true
		else:
			# - WEST
			$AnimatedSprite2D.play("stand_d")
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		if (direction.y > 0):
			# | NORTH
			$AnimatedSprite2D.play("stand_f")
		else:
			# | SOUTH
			$AnimatedSprite2D.play("stand_f")
