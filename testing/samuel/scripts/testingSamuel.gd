extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# yield still doesnt work
	$popupUI/popupBox.showText("[color=purple]Johnny[/color]", "I am [wave amp=60 freq=6][color=red]very[/color][/wave] angry right now.")	
	yield($popupUI/popupBox, "messageEnded")
	$popupUI/popupBox.showText("Alex", "SHEEEEEESH")
	yield($tenSecTimer, "timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
