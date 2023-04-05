# Work in Progress -- 
extends RigidBody2D

signal _apply_position(current_position)

export (Vector2) var current_position = get_position()
enum {
	MOVING,
	RESTING,
}

var current_state = RESTING

func _ready():
	connect("body_entered", self, "_on_object_body_entered")

func _integrate_forces(state):
	match current_state:
		MOVING:
			_moving_state(state)
		RESTING:
			_resting_state(state)

func _moving_state(state):
	if get_parent().get_node("KinematicBody2D").global_position > self.global_position:
		set_linear_velocity(Vector2(-1, 0))
		set_position(get_position())
		emit_signal("_apply_position", current_position)
	elif get_parent().get_node("KinematicBody2D").global_position < self.global_position:
		set_linear_velocity(Vector2(1, 0))
		set_position(get_position())
		emit_signal("_apply_position", current_position)


func _resting_state(state):
	pass

func _on_object_body_entered(area: Node) -> void:
	if area.get_name() == "KinematicBody2D":
		current_state = MOVING
	else:
		current_state = RESTING
