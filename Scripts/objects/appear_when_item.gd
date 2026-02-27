extends Sprite2D

@export var item : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.inventoryUpdate.connect(updateStatus)
	updateStatus()

func updateStatus():
	if GlobalVariables.in_inventory(item):
		show()
	else:
		hide()
