extends RigidBody2D
signal noteTouched
var touched = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_RigidBody2D_body_entered(body):
	emit_signal("noteTouched")
	print("Note was touched (alarmNote)")
	queue_free()
