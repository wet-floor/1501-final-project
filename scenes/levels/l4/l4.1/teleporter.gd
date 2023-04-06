extends Area2D

func _ready():
	connect("body_entered", self, "on_teleporter_entered")

func _teleport():
	if get_parent().name == "l4-1":
		get_tree().change_scene("res://scenes/levels/l4/l4.1/l4-2.tscn")
	elif get_parent().name == "l4-2":
		get_tree().change_scene("res://scenes/levels/l4/l4.1/l4-1.tscn")

func on_teleporter_entered(area : Node) -> void:
	if area.get_name() == "KinematicBody2D":
		_teleport()
