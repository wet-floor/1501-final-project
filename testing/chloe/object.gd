extends RigidBody2D

signal apply_damage(damage)

export (bool) var breakable = false
export (bool) var harmful = false

export (float) var gravity = 0
export (float) var object_weight = 1

export (Vector2) var velocity = Vector2(0, 1)

enum {
	BOUNDARY,
	FREE,
	PLAYER,
}

var current_state = FREE

func _ready():
	pass

func _integrate_forces(state) -> void:
	set_angular_velocity(0)
	
	match current_state:
		BOUNDARY:
			boundary_state(state)
		FREE:
			free_state(state)
		PLAYER:
			player_state(state)

func boundary_state(state) -> void:
	# if breakable: queue free
	pass

func free_state(state) -> void:
	set_linear_velocity((velocity * gravity) / object_weight)

func player_state(state) -> void:
	pass
	# if harmful and breakable: queue free, apply damage
	# elif harmful: apply damage
	# elif breakable: queue free
	# else: gain player velocity for singular instant

# set state based on object entered
