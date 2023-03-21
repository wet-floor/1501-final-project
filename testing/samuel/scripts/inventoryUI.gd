extends Control

var hehe

func _on_MenuButton_pressed():
	hehe = get_node("/root/testingSamuel/Root/tdPlayer/Hand/Inventory").get_inventory()
	
	#print(hehe)
	#get_tree().paused = true
	pass 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
