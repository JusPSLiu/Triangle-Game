extends TextureRect
class_name combo_lock

@export var key : String
@export var combination : String = "12345"
@export var opening_animator : AnimationPlayer

var array_combination : Array

var current_combination = null
var kids : Array[Control]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		kids.append(child)
		child.connect("updateCombo", combo_updated)
	
	for letter in combination.length():
		array_combination.append(int(combination[letter]))
	while array_combination.size() < kids.size():
		array_combination.append(0)
	
	start()

func start():
	if (GlobalVariables.in_inventory(key)):
		# COMPLETED. display open safe
		opening_animator.play("Opened")
		return
	
	if (current_combination == null):
		seed(42)
		current_combination = [0, 0, 0, 0, 0]
		for i in range(5):
			current_combination[i] = randi_range(0, 9)
	
	set_kids(current_combination)

func set_kids(combo : Array):
	for i in kids.size():
		kids[i].set_combo(combo[i])

func combo_updated():
	for i in kids.size():
		current_combination[i] = kids[i].currValue
	
	if (current_combination == array_combination):
		GlobalVariables.add_to_inventory(key)
		opening_animator.play("OpenSafe")
