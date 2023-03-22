extends Control

var template_inv_slot = load("res://testing/samuel/InventorySlot.tscn")

onready var gridcontainer = $Background/M/V/ScrollContainer/GridContainer

# Testing var
var numberOfBoxes = 3
var x = 0

func _ready():
	pass
		
func update_inventory(inv):
	
	var inventoryArray= inv.get_inventory()
	if inventoryArray == null:
		return
		
	# If inventory Array[i] isnt null, add a box. However it seems the array is always null
	for i in range(inventoryArray.size()):
		# if the array index is not null, add box
		if inventoryArray[i] != null:
			var inv_slot_new = template_inv_slot.instance()
			var itemName = inv.get_current_item()
			var iconTexture = load ("res://testing/samuel/assets/" + itemName + ".png")
			inv_slot_new.get_node("Icon").set_texture(iconTexture)
			gridcontainer.add_child(inv_slot_new, true)
		# If it is, remove box
		else:
			if gridcontainer.get_child_count() > 0:
				gridcontainer.remove_child(gridcontainer.get_child(i))
	
	
	# Temporary testing
func testing():
	if x < numberOfBoxes:
		x += 1
		var inv_slot_new = template_inv_slot.instance()
		gridcontainer.add_child(inv_slot_new, true)
