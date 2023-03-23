extends Node


onready var popupBox = $popupUI/popupBox


func _ready():
	popupBox.showText("[center][color=purple]Johnny", "normal text[wave amp=60 freq=6][color=red]red and wavy text[/color][/wave] [i]tiny text")	
	popupBox.showText("[center]Alex", "[wave amp=100 freq=15]second message very wavy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
