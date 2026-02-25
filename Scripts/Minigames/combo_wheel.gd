extends TextureRect

@export var values : Array[int]
@export var spinRate = 0.4

var clickPos : float = 0.0
var clicked : bool = false
var currValue = 1
var mouseOnMe = false
var spinVelocity : float = 0
var currypos : float = 0.0

@onready var myTexture = self.texture

signal updateCombo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("click")):
		if (mouseOnMe and !clicked and Input.is_action_just_pressed("click")):
			clicked = true
			clickPos = myTexture.region.position.y / spinRate + get_global_mouse_position().y
		elif clicked:
			var diff = ((clickPos-get_global_mouse_position().y)*spinRate - myTexture.region.position.y)
			spinVelocity = lerp(spinVelocity, diff/delta, 0.5)

			myTexture.region.position.y = (clickPos-get_global_mouse_position().y)*spinRate
			currypos = myTexture.region.position.y
			currValue = -99
	elif (currValue == -99): # just settling now
		clicked = false
		if (abs(spinVelocity) > 20): # INERTIA SIMULATOR
			currypos += spinVelocity*delta * 0.8
			myTexture.region.position.y = int(currypos)
			spinVelocity *= 0.9
			return
		# LOCK INTO PLACE
		var curr_pos = myTexture.region.position.y
		var nearest = roundi(curr_pos/27.0)*27.0
		myTexture.region.position.y = lerp(curr_pos, nearest, delta*20)
		if (abs(curr_pos-nearest) < 1):
			nearest = fposmod((nearest/27.0), float(values.size()))
			currValue = values[nearest]
			myTexture.region.position.y = nearest*27
			
			emit_signal("updateCombo")

func set_combo(number : int):
	var idx = values.find(number)
	idx = fposmod(idx, float(values.size()))
	myTexture.region.position.y = idx*27
	currValue = values[idx]


func _on_mouse_entered() -> void:
	mouseOnMe = true

func _on_mouse_exited() -> void:
	mouseOnMe = false
