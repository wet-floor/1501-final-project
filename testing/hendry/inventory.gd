extends Area2D


var inventory = [null]
var currently_selected = 0


# based on mouse wheel, change currently selected inventory item
func get_input():
	if Input.is_action_pressed("inv_left"):
		if currently_selected - 1 == -1:
			currently_selected = inventory.size() - 1
		else:
			currently_selected -= 1
		print(inventory[currently_selected])

	if Input.is_action_pressed("inv_right"):
		if currently_selected + 1 == inventory.size():
			currently_selected = 0
		else:
			currently_selected += 1
		print(inventory[currently_selected])


# called by the player scene, add items to the inventory
func add_item(item : Node2D):
	inventory.append(item)


func _physics_process(delta):
	get_input()

	# make sure all but one item is displayed
	for item in inventory:
		var n : Node2D = item
		item.hide()
		item.set_physics_process(false)
		add_child(n)
	
	inventory[currently_selected].show()
	inventory[currently_selected].set_physics_process(true)
	
	# TODO: some inventory items don't get displayed and instead has many items within it
	if inventory[currently_selected].body_is_in_group("stackable"):
		pass


func get_current_item():
	return inventory[currently_selected]

