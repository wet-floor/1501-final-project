extends Control

var template_inv_slot = load("res://testing/samuel/InventorySlot.tscn")

onready var gridcontainer = $Background/M/V/ScrollContainer/GridContainer

# Testing var
var numberOfBoxes = 3
var x = 0

func _ready():
	pass
		
func update_inventory2(player):
	var inventoryArray= player.get_inventory()
	if inventoryArray == null:
		return
	
	# If inventory Array[i] isnt null, add a box. However it seems the array is always null
	for i in range(inventoryArray.size()):
		# if the array index is not null, add box
		if inventoryArray[i] != null:
			var inv_slot_new = template_inv_slot.instance()
			#var itemName = player.get_inventory()
			var itemIndex = player.get_currently_selected_index()
			#var iconTexture = load("res://testing/samuel/assets/" + itemName + ".png")
			#inv_slot_new.get_node("Icon").set_texture(iconTexture)
			gridcontainer.add_child(inv_slot_new, true)
		# If it is, remove box
		else:
			if gridcontainer.get_child_count() > 0:
				gridcontainer.remove_child(gridcontainer.get_child(i))

func update_inventory(player):
	var inventoryArray = player.get_inventory()
	if inventoryArray == null:
		return
	
	var numNonNullItems = 0
	for i in range(inventoryArray.size()):
		if gridcontainer.get_child_count() > 0:
			gridcontainer.remove_child(gridcontainer.get_child(i))
				
	for i in range(inventoryArray.size()):
		if inventoryArray[i] != null:
			numNonNullItems += 1
			if numNonNullItems >= gridcontainer.get_child_count():
				var inv_slot_new = template_inv_slot.instance()
				gridcontainer.add_child(inv_slot_new, true)
				#numNonNullItems += 1
			else:
				break
	return inventoryArray

	
	# Temporary testing
func testing():
	if x < numberOfBoxes:
		x += 1
		var inv_slot_new = template_inv_slot.instance()
		gridcontainer.add_child(inv_slot_new, true)
