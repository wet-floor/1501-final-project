extends Node

var a = 0
onready var player = $tdPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	#$alarmBar/Path2D/spawnTimer.start()
	pass
	#$level3/spawnTimer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$inventoryUI.update_inventory(player)

func _on_Timer_timeout():
	
	print("player inventory: " + str($inventoryUI.update_inventory(player)))
	$inventoryUI.update_inventory(player)
	var inventoryArray = player.get_inventory() as Array
	print("gridcont children count: " + str($inventoryUI/Background/M/V/ScrollContainer/GridContainer.get_child_count()))
	print(inventoryArray[0])
	print(player.get_inventory())
	
	a += 1
	print(str(a) + ": " + str($level3.getNoteCount()))
