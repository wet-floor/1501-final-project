extends Node

export(PackedScene) var joggers_scene


onready var player = get_node("tdPlayer")
onready var jogger = get_node("Joggers")
onready var jogger_contained = get_node("Joggers2")

var joggers = []
var jogger_spawn_positions = []


# Called when the node enters the scene tree for the first time.
func _ready():
	jogger_spawn_positions = [
		Vector2(50, 50), # Top left corner
		Vector2(get_viewport().get_size().x - 50, 50), # Top right corner
		Vector2(50, get_viewport().get_size().y - 50), # Bottom left corner
		Vector2(get_viewport().get_size().x - 50, get_viewport().get_size().y - 50) # Bottom right corner
	]
	
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for jogger in joggers:
		var direction = (player.position - jogger.position).normalized()
		var speed = 150
		var velocity = direction * speed * delta
		jogger.position += velocity
	



func _on_SpawnTimer_timeout():
	for i in range(4):
		var jogger = joggers_scene.instance()
		add_child(jogger)
		
		# Check if the jogger is still in the scene tree
		if jogger.is_inside_tree():
			jogger_contained.add_child(jogger)
		jogger.position = jogger_spawn_positions[i]
		joggers.append(jogger)
	
	
