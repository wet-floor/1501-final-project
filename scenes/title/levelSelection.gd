extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$levelSelectionPanel.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_levelSelection_pressed():
	$levelSelectionPanel.show()

func _on_levelSelect1_pressed():
	get_tree().change_scene("res://scenes/levels/l1/l1-1.tscn")
	pass # Replace with function body.
