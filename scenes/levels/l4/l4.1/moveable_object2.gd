extends RigidBody2D

func _ready():
	set_position(Coordinates.object_position2)

func _integrate_forces(state):
	Coordinates.object_position2 = get_position()
