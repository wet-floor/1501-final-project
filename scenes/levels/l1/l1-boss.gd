extends Node
	

# Called when the node enters the scene tree for the first time.
func _ready():
	Physics2DServer.area_set_param(get_viewport().get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass
