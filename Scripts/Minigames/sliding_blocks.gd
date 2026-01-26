extends GridContainer
class_name griddy



@export var cols = 3
@export var rows = 3
@export var completeKey : String = ""
@export var key : AnimationPlayer

@onready var null_num = cols*rows-1
var null_button : Control
var internal_grid : Array[Control]
var displayed_grid : Array[Control]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	var i=0
	for child in get_children():
		child.connect("pressed", button_pressed.bind(i))
		internal_grid.append(child)
		i += 1
		null_button = child # bottom right one is assumed null
	# create secondary display grid
	displayed_grid = internal_grid.duplicate_deep()
	# scramble
	if (!GlobalVariables.in_inventory(completeKey)):
		scramble()

func scramble():
	var i = 1
	var curr = 0
	for button in internal_grid:
		curr+=1
		if (curr % i == 0 and curr != cols*rows):
			i -= 1
			if (i < 1): i = cols
			swap_display(curr-1, ((curr+i) % cols*rows)-2)
	update_display()


func start():
	show()
	null_num = cols*rows-1

func button_pressed(button_num : int):
	if (GlobalVariables.in_inventory(completeKey)):
		return
	var button = internal_grid[button_num]
	var index = displayed_grid.find(button)
	if (index < 0):
		#print_debug("THE DUPLICATE_DEEP() HAS FAILED.")
		return
	
	if (index%cols != cols-1 and space_free(index+1)): # R
		swap_display(index, index+1)
	elif (index%cols != 0 and space_free(index-1)): # L
		swap_display(index, index-1)
	elif (index >= cols and space_free(index-cols)): # UP
		swap_display(index, index-cols)
	elif (index < cols*(rows-1) and space_free(index+cols)): # DOWN
		swap_display(index, index+cols)
	
	update_display()

func space_free(index):
	return (displayed_grid.size() > index and displayed_grid[index] == null_button)

func swap_display(index1, index2):
	var temp = displayed_grid[index1]
	displayed_grid[index1] = displayed_grid[index2]
	displayed_grid[index2] = temp

func update_display():
	for child in get_children():
		var index = displayed_grid.find(child)
		if (index < 0):
			#print_debug("WTF LITERALLY EVERYTHING HAS FAILED.")
			return
		move_child(child, index)
	
	# if solved, FREEZE ALL, MARK AS SOLVED
	if (internal_grid == displayed_grid):
		GlobalVariables.add_to_inventory(completeKey)
		for child in get_children():
			child.disabled = true
		if (key is AnimationPlayer):
			key.play("key_get")
	
	# DEBUG PRINT
	'''var i = 0
	var currString : String = ""
	for but in displayed_grid:
		currString += str(internal_grid.find(but)+1) + " "
		i+=1
		if (i % cols == 0):
			print(currString)
			currString = ""
	print(currString)'''
