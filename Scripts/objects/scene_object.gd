extends Node2D
class_name scene_object

var behind : int = true
@onready var parent = get_parent()

# get the left and right corners dynamically
# (so object can move behind player visibility layer dynamically)
var leftHeight : float = 0
var rightHeight : float = 0
var cutoffX : float = 0

func _ready() -> void:
	calculateBoundary()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (parent is Node2D):
		if (behind):
			# behind player, check if must go in front
			# check if player is behind me
			if (!isPlayerInFront(parent.player_position)):
				z_index =  parent.layerInFront
				behind = false
		else:
			# in front of player, check if go behind
			# check if should be behind player pos
			if (isPlayerInFront(parent.player_position)):
				z_index =  parent.layerBehind
				behind = true


# check if player is in front of this collision object
# player is in front if player y is greater than meeee (plus my height offset)
func isPlayerInFront(player_position : Vector2) -> bool:
	if (player_position.x > global_position.x + cutoffX):
		# player is to right, check right side
		return player_position.y > global_position.y + rightHeight
	else:
		# player is to left, check left side
		return player_position.y > global_position.y + leftHeight

func calculateBoundary():
	# get the physics points
	var points = $Collision/CollisionShape2D.polygon
	# iterate through physics points
	var leftmost : Vector2 = Vector2(0, 0)
	var rightmost : Vector2 = Vector2(0, 0)
	var topmost : Vector2 = Vector2(0, 0)
	var bottommost : Vector2 = Vector2(0, 0)
	for point in points:
		if (point.x < leftmost.x):
			leftmost = point
		if (point.x > rightmost.x):
			rightmost = point
		if (point.y < topmost.y):
			topmost = point
		if (point.y > bottommost.y):
			bottommost = point
	# set the leftmost/rightmost y position, cutoff on the ground
	leftHeight = leftmost.y
	rightHeight = rightmost.y
	# cutoff is halfway btwm topmost and bottommost
	cutoffX = (topmost.x+bottommost.x)*0.5
