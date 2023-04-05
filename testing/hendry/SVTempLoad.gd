extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ProjectSettings.set("physics/2d/default_gravity_vector", Vector2(0, 1))
	get_tree().change_scene("res://scenes/levels/l1/l1-boss.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
