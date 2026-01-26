extends Control

var resettableChildren : Array[Node]
@export var sounds : Array[AudioStreamPlayer]
var currState = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# dynamically iterate through all immediate children
	# if paper then add to resettable children
	for child in get_children():
		if (child is papery):
			resettableChildren.push_front(child)
			child.inc_state.connect(increment_state)
		if (child is griddy or child is freekey):
			resettableChildren.push_front(child)
	# give each child a state index (will only be movable when "currState" matches the "placement")
	var curr_indx = 0
	for child in resettableChildren:
		if (child is papery):
			child.placement = curr_indx
			curr_indx += 1
	
	# if in game, hide
	if get_parent() is not Window:
		hide()
	else:
		# if in debug mode, load properly
		show()
		_enter()

func _exit() -> void:
	SignalBus.emit_signal("exited_minigame")
	stop_sound()
	hide()
	currState = 0

func _enter():
	SignalBus.emit_signal("entered_minigame")
	currState = 0
	show()
	reset_kids()
	start_sound()

func increment_state(newState : int):
	currState = newState + 1
	for child in resettableChildren:
		child.update_state()

func reset_kids():
	for child in resettableChildren:
		child.start()

func start_sound():
	for sound in sounds:
		sound.play()
func stop_sound():
	for sound in sounds:
		sound.stop()
