extends RigidBody2D

export var KillCount = 75
export var KillsNeeded = 75
signal kill

func _ready():
	contact_monitor = true
	
	#set_position(Coordinates.signSpawn)
	#print(Coordinates.signSpawn)
	pass

func _integrate_forces(state):
	#Coordinates.signSpawn = get_position()
	pass



func _on_Area2D_body_entered(body):
	# Check if the body is an enemy
	if body.has_method("take_damage"):
		KillsNeeded -= 1
		emit_signal("kill")
		# Deal damage to the enemy
		body.take_damage(10)

		# Check if the enemy has died and remove it if it has
		if body.health <= 0:
			body.queue_free()

