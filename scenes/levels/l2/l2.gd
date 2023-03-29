extends Node

export(PackedScene) var joggers_scene


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():
	var jogger = joggers_scene.instance()
	
	var spawn_location = get_node("SpawnPoint/SpawnPath/SpawnPathFollow")
	print(spawn_location)
	spawn_location.offset = randi()
	
	jogger.position = spawn_location.position
	
	var velocity = Vector2(rand_range(400.0,550.0),0.0)
	
	add_child(jogger)
