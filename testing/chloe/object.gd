extends RigidBody2D

export (bool) var apply_gravity = false
export (bool) var breakable = false
export (bool) var harmful = false

enum {
	FLOOR,
	FREE,
	PLAYER,
	WALL,
}

var current_state = FREE

func _physics_process(delta):
	match current_state:
		FLOOR:
			floor_state(delta)
		FREE:
			free_state(delta)
		PLAYER:
			player_state(delta)
		WALL:
			wall_state(delta)

func floor_state(delta):
	pass

func free_state(delta):
	pass

func player_state(delta):
	pass

func wall_state(delta):
	pass
