extends Position2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _set_location(newLocation):
	$postionVector2D.position = newLocation
