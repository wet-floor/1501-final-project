extends KinematicBody2D

export (int) var move_speed = 100
export (NodePath) var follow_path

# states
enum States {START, CHASE, THWOMP, PROJECTILE, DEAD}
var state : int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	match state:
		States.START:
			pass
		States.CHASE:
			pass
		States.THWOMP:
			pass
		States.PROJECTILE:
			pass
		States.DEAD:
			pass


func get_state():
	return state


func set_state(newState : int):
	state = newState
