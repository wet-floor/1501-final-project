extends Node


export (int, 0, 2) var health = 1

export var speed = 150

var rect = Rect2()



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func _process(delta):
	if health <= 0:
		# The enemy has been killed
		
		queue_free()
	
	#if is_offscreen():
		#queue_free()
		#print("FUCK YOU")

func take_damage(damage):
	health -= damage

#thanks lucas


func _on_Area2D_body_entered(body):
	if body.has_method("suck"):
		get_tree().reload_current_scene()

