extends Control

var resettableChildren : Array[Node]
var currState = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Node2D:
		hide()
	
	# dynamically iterate through all immediate children
	# if paper then add to resettable children
	for child in get_children():
		if (child is papery):
			resettableChildren.push_front(child)
			child.connect("inc_state", increment_state)
	# give each child a state index (will only be movable when "currState" matches the "placement")
	var curr_indx = 0
	for child in resettableChildren:
		child.placement = curr_indx
		curr_indx += 1

func _exit() -> void:
	SignalBus.emit_signal("exited_minigame")
	hide()
	currState = 0

func _enter():
	SignalBus.emit_signal("entered_minigame")
	currState = 0
	show()
	reset_kids()

func increment_state():
	print("INCREMENTED STATE")
	currState += 1
	for child in resettableChildren:
		child.update_state()

func reset_kids():
	for child in resettableChildren:
		child.start()
