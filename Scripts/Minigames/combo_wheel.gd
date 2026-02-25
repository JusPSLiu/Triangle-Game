extends TextureRect

@export var values : Array[int]
@export var spinRate = 0.4

var clickPos : float = 0.0
var clicked : bool = false
var currValue = 1
var mouseOnMe = false

@onready var myTexture = self.texture



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("click")):
		if (mouseOnMe and !clicked):
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
			print(nearest/27.0)
			print(values.size())
			print(fposmod((nearest/27.0), float(values.size())))
			nearest = fposmod((nearest/27.0), float(values.size()))
			currValue = values[nearest]
			print(currValue)
			myTexture.region.position.y = nearest*27


func _on_mouse_entered() -> void:
	mouseOnMe = true


func _on_mouse_exited() -> void:
	mouseOnMe = false
