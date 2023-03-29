extends RigidBody2D

signal apply_damage(damage)

export (bool) var breakable = false
export (bool) var harmful = false

export (float) var gravity = 0
export (float) var object_weight = 1

export (int) var damage = 1

export (Vector2) var velocity = Vector2(0, 1)

enum {
	BOUNDARY,
	FREE,
	PLAYER,
}

var current_state = FREE

func _ready():
	connect("body_entered", self, "_on_object_body_entered")

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
	set_linear_velocity((velocity * gravity) / object_weight)
	
	if breakable == true:
		queue_free()

func free_state(state) -> void:
	set_linear_velocity((velocity * gravity) / object_weight)

func player_state(state) -> void:
	set_linear_velocity((velocity * gravity) / object_weight)
	
	if breakable == true and harmful == true:
		emit_signal("apply_damage", damage)
		queue_free()

func _on_object_body_entered(area : Node) -> void:
	if area.get_name() == "KinematicBody2D":
		current_state = PLAYER
	elif area.get_name() == "TileMap":
		current_state = BOUNDARY
	else:
		current_state = FREE
