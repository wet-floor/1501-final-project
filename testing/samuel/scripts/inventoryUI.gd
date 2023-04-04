extends Control

var template_inv_slot = load("res://testing/samuel/InventorySlot.tscn")

onready var gridcontainer = $Background/M/V/ScrollContainer/GridContainer

var numNonNullItems = 0

var x = 0

func _ready():
	pass

func getNonNull():
	return numNonNullItems

func update_inventory(player):
	var inventoryArray = player.get_inventory() as Array
	if inventoryArray == null:
		return
	
	numNonNullItems = 0
	
	# For every item in the player's inventory,
	for i in range(inventoryArray.size()):
		# remove all grids
		if gridcontainer.get_child_count() > 0:
			for x in range(gridcontainer.get_child_count()):
				gridcontainer.remove_child(gridcontainer.get_child(0))
	
	# Add items back
	for i in range(inventoryArray.size()):
		if inventoryArray[i] != null:
			numNonNullItems += 1
				
			if numNonNullItems >= gridcontainer.get_child_count():
				var inv_slot_new = template_inv_slot.instance()
				# Testing
				inv_slot_new.setName(player.get_inventory()[i])
				
				gridcontainer.add_child(inv_slot_new, true)
			else:
				break
	return inventoryArray

func _process(_delta):
	if gridcontainer.get_child_count() == 0:
		var inv_slot_new = template_inv_slot.instance()
		gridcontainer.add_child(inv_slot_new, true)
