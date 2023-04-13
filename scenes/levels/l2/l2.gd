extends Node

export(PackedScene) var joggers_scene


onready var player = get_node("tdPlayer")
onready var jogger = get_node("Joggers")
onready var jogger_contained = get_node("Joggers2")
onready var dialogue_box = get_node("popupUI/popupBox")
onready var wetFloor = get_node("wetFloorSign")

var joggers = []
var jogger_spawn_positions = []
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var start = false


# Called when the node enters the scene tree for the first time.
func _ready():
	jogger_spawn_positions = [
		Vector2(50, 50), # Top left corner
		Vector2(get_viewport().get_size().x - 50, 50), # Top right corner
		Vector2(50, get_viewport().get_size().y - 50), # Bottom left corner
		Vector2(get_viewport().get_size().x - 50, get_viewport().get_size().y - 50) # Bottom right corner
	]
	
	connect("kill", self, "update_dialogue_box_text")
	
	randomize()
	rng.randomize()
	
	$popupUI.show()
	dialogue_box.showText("[color=white][center]You", "[color=white]I needed some fresh air after that...[/color]")
	dialogue_box.showText("[color=white][center]You", "[color=white]What!? Rush hour already? Guess I'll have to deal with the work zombies.[/color]")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if start == true:
		for jogger in joggers:
			if is_instance_valid(jogger):
				var direction = (player.position - jogger.position).normalized()
				var velocity = direction * jogger.speed * delta
				jogger.position += velocity
				
		

	


func _on_SpawnTimer_timeout():
	if start == true:
		var jogger = joggers_scene.instance()
		jogger.speed = rng.randi_range(200, 450)
		add_child(jogger)
		
		jogger.position = jogger_spawn_positions[rng.randi_range(0,3)]
		joggers.append(jogger)



func update_dialogue_box_text():
	dialogue_box.showText("[color=white]Kills needed: [/color]", str(wetFloor.KillsNeeded))
	

func _on_Timer_timeout():
	start = true
	$Music.play()


func _on_wetFloorSign_kill():
	update_dialogue_box_text()
	dialogue_box.end_dialogue = false
	


func _on_TextTimer_timeout():
	if start == true:
		dialogue_box.end_dialogue = true
