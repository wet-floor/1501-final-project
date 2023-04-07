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
