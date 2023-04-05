extends RigidBody2D

func _ready():
	set_position(Coordinates.object_position)

func _integrate_forces(state):
	Coordinates.object_position = get_position()
