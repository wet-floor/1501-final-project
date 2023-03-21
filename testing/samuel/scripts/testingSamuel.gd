extends Node2D
var playerText = ""
var playerName = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	$popupUI/popupBox.showText("[color=purple]Johnny[/color]", "I am [wave amp=60 freq=6][color=red]VERY[/color][/wave] angry right now.")	
	$popupUI/popupBox.showText("Alex", "SHEEEEEEEEEEEEEEEEEEEEEEEEEEEEEESH")

func _on_Button_pressed():
	playerText = $showTextButton/textText.text 
	playerName = $showTextButton/nameText.text
	$popupUI/popupBox.showText(playerName, playerText)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
