extends RigidBody2D

var screensize


# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	pass # Replace with function body.


func _physics_process(delta):
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if position.x > screensize.x - 100:
		position.x = screensize.x - 100
	if position.x < 100:
		position.x = 100
	if position.y > screensize.y - 100:
		position.y = screensize.y - 100
	if position.y < 100:
		position.y = 100
	
	# print(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)
	pass
