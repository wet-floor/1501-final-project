extends Position2D

var location = Vector2(0, 0);
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _set_location(newLocation):
	location = newLocation

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
