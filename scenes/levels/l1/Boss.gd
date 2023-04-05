extends KinematicBody2D

export (int) var move_speed = 100
export (NodePath) var follow_path

# states
enum state {chase, thwomp}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_state():
	return state
