extends Area2D


var inventory = [null]
var currently_selected = 0


# based on mouse wheel, change currently selected inventory item
func get_input():
	if Input.is_action_just_released("inv_left"):
		if currently_selected - 1 == -1:
			currently_selected = inventory.size() - 1
		else:
			currently_selected -= 1
		print(inventory[currently_selected])
		# print(get_children())

	if Input.is_action_just_released("inv_right"):
		if currently_selected + 1 == inventory.size():
			currently_selected = 0
		else:
			currently_selected += 1
		print(inventory[currently_selected])
		# print(get_children())


# add items to the inventory
func add_item(item : RigidBody2D):
	# item.linear_velocity = Vector2.ZERO
	# item.angular_velocity = 0
	inventory.append(item)
	if inventory[currently_selected] == null:
		currently_selected = inventory.find(item)


# get the currently selected item
func get_current_item():
	return inventory[currently_selected]


func get_inventory():
	return inventory


func release_item():
	if inventory[currently_selected] != null:
		# var released_item : RigidBody2D 
		# released_item = inventory[currently_selected]
		# released_item.set_physics_process(true)
		inventory.pop_at(currently_selected)
		
		currently_selected -= 1


func release_item_at_index(index):
	if inventory[index] != null:
		inventory.pop_at(index)
		
		currently_selected -= 1


func _physics_process(delta):
	get_input()

	# make sure all but one item is displayed
	# 1. hide everything
	for item in inventory:
		var n : RigidBody2D = item
		if item != null:
			n.hide()
			n.collision_layer = 0
			n.collision_mask = 0
			
			# n.global_position = global_position
			# n.global_rotation = global_rotation
			# n.linear_velocity = Vector2.ZERO
			# n.angular_velocity = 0
	
	# 2. show the thing that's currently selected
	if inventory[currently_selected] != null:
		var n : RigidBody2D = inventory[currently_selected]
		n.show()
		n.collision_layer = 1
		n.collision_mask = 1
	
		# TODO: some inventory items don't get displayed and instead has many items within it
		#if inventory[currently_selected].body_is_in_group("stackable"):
