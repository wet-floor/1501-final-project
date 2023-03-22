extends Node2D

var playerText = ""
var playerName = ""

var popupBox
var textText
var nameText

onready var player = $tdPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets the nodes as variables
	popupBox = $popupUI/popupBox
	textText = $showTextButton/textText
	nameText = $showTextButton/nameText
	
	popupBox.showText("[center][color=purple]Johnny", "I am [wave amp=60 freq=6][color=red]VERY[/color][/wave] angry right now.")	
	popupBox.showText("[center]Alex", "[wave amp=100 freq=15]SHEEEEEEEEEEEEEEEEEEEEEEEEEEEEEESH")

func _on_Button_pressed():
	playerText = textText.text
	playerName = nameText.text
	popupBox.showText(playerName, playerText)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$inventoryUI.update_inventory(player)
	pass

func _on_Timer_timeout():
	print("player inventory: " + str($inventoryUI.update_inventory(player)))
	$inventoryUI.update_inventory(player)
	var inventoryArray = player.get_inventory() as Array
	print("gridcont children count: " + str($inventoryUI/Background/M/V/ScrollContainer/GridContainer.get_child_count()))
	#print(inventoryArray[0])
	#print(player.get_inventory())
	#$inventoryUI.testing()
	pass
	
