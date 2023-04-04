extends RigidBody2D

export (int) var storage = 3
export(PackedScene) var ejected_object

export var ejected_min = 1
export var ejected_max = 1

export var ready = true

export var ejected_object_group = ""

# var rng = RandomNumberGenerator.new()

onready var path : Path2D = get_node("SpawnPath")
onready var spawn_location : PathFollow2D  = get_node("SpawnPath/SpawnLocation")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func eject(player_position):
	if storage > 0 and ready == true:
		var ejected_object_instance = ejected_object.instance()
		get_parent().add_child(ejected_object_instance)
		
		spawn_location.offset = path.curve.get_closest_offset(path.to_local(player_position))
		
		ejected_object_instance.global_position = spawn_location.global_position
		ejected_object_instance.set_linear_velocity(Vector2(rand_range(ejected_min, ejected_max), 0))
		ejected_object_instance.add_to_group("body")
		ejected_object_instance.add_to_group("object")
		ejected_object_instance.add_to_group(ejected_object_group)
		
		storage -= 1
		ready = false

func get_storage():
	return storage

func toggle_readiness(boolean : bool):
	ready = boolean
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
