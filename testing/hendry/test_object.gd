extends RigidBody2D

var screensize


func _physics_process(delta):
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	
	# print(position)

