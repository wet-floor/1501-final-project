extends RigidBody2D


func _ready():
	contact_monitor = true
	#set_position(Coordinates.signSpawn)
	#print(Coordinates.signSpawn)
	pass

func _integrate_forces(state):
	#Coordinates.signSpawn = get_position()
	pass



func _on_Area2D_body_entered(body):
	print("I ran")
	# Check if the body is an enemy
	if body.has_method("take_damage"):
		print("I ran2")
		# Deal damage to the enemy
		body.take_damage(10)

		# Check if the enemy has died and remove it if it has
		if body.health <= 0:
			body.queue_free()
