extends KinematicBody2D


export var speed = 500
export var friction = 0.2
export var acceleration = 0.4

var velocity = Vector2.ZERO
var input_dir = Vector2.ZERO

var screensize


# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	pass # Replace with function body.


func get_input():
	input_dir = Vector2.ZERO

	if Input.is_action_pressed("player_right"):
		print("right")
		input_dir.x += 1
	
	if Input.is_action_pressed("player_left"):
		print("left")
		input_dir.x -= 1
	
	if Input.is_action_pressed("player_up"):
		print("up")
		input_dir.y -= 1

	if Input.is_action_pressed("player_down"):
		print("down")
		input_dir.y += 1
	
	input_dir = input_dir.normalized()
	
	if input_dir.x != 0:
		velocity.x = lerp(velocity.x, input_dir.x * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	if input_dir.y != 0:
		velocity.y = lerp(velocity.y, input_dir.y * speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0, friction)
	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	
func _process(delta):
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
