extends TextureRect

@export var values : Array[int]
@export var spinRate = 0.4

var clickPos : float = 0.0
var clicked : bool = false
var currValue = 1
var mouseOnMe = false

@onready var myTexture = self.texture

signal updateCombo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("click")):
		if (mouseOnMe and !clicked and Input.is_action_just_pressed("click")):
			clicked = true
			clickPos = myTexture.region.position.y / spinRate + get_global_mouse_position().y
		elif clicked:
			myTexture.region.position.y = (clickPos-get_global_mouse_position().y)*spinRate
			currValue = -99
	elif (currValue == -99): # just settling now
		clicked = false
		var curr_pos = myTexture.region.position.y
		var nearest = roundi(curr_pos/27.0)*27.0
		myTexture.region.position.y = lerp(curr_pos, nearest, delta*10)
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
