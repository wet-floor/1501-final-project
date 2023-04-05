extends Node

# nodes
onready var boss = get_node("Boss")
onready var player = get_node("Player")

# fields
var player_position : Vector2

func _ready():
	Physics2DServer.area_set_param(get_viewport().get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))
	pass # Replace with function body.
	

func _physics_process(delta):
	player_position = player.global_position
	pass
