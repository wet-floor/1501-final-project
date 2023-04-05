extends RigidBody2D

func _ready():
	pass

func _integrate_forces(state):
	set_position(Coordinates.object_position)
