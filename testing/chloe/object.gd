extends RigidBody2D

export (bool) var apply_gravity = false
export (bool) var breakable = false
export (bool) var harmful = false

export (float) var gravity = 9.81
export (float) var object_weight = 1
export (Vector2) var velocity = Vector2(0, 1)

enum {
	FLOOR,
	FREE,
	PLAYER,
	WALL,
}

var current_state = FREE

func _ready():
	pass

func _integrate_forces(state) -> void:
	set_angular_velocity(0)
	match current_state:
		FLOOR:
			floor_state(state)
		FREE:
			free_state(state)
		PLAYER:
			player_state(state)
		WALL:
			wall_state(state)

func floor_state(state) -> void:
	pass

func free_state(state) -> void:
	if apply_gravity == true:
		set_linear_velocity((velocity * gravity) / object_weight)

func player_state(state) -> void:
	pass

func wall_state(state) -> void:
	pass
